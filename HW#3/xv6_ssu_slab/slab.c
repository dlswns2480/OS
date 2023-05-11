#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "slab.h"
#include "stdbool.h"

struct {
	struct spinlock lock;
	struct slab slab[NSLAB];
} stable;

bool get_bit(char* size, int i)
{
	char *tmp = size;
	tmp += (i / 8);
	i = i - (i / 8) * 8;
	unsigned char mask = 128;
	if((*(tmp + i) & (mask >> i)) != 0)
	{
		return true;
	} 
	else{
		return false;
	} 
	
}

char* set_bit(char* size, int i)
{
	char *tmp = size;
	tmp += (i / 8);
	i = i - (i / 8) * 8;
	unsigned char mask = 128;
	*(tmp + i) = (*(tmp + i) | (mask >> i));
	return tmp;
}

char* clear_bit(char* size, int i) {

  	char *tmp = size;
	tmp += (i / 8);
	i = i - (i / 8) * 8;
	unsigned char mask = 128;
	*(tmp + i) = *(tmp + i) & ~(mask >> i);
	return tmp;
}


void slabinit(){



	//initlock(&stable.lock, "stable");
	//acquire(&stable.lock);
	int init_size = 8;
	for(int i=0; i<NSLAB; i++){
		stable.slab[i].size = init_size;
		for(int j=0; j< i; j++)
			stable.slab[i].size  = stable.slab[i].size << 1;
		
		stable.slab[i].num_pages = 0;
		stable.slab[i].num_objects_per_page = 4096 / stable.slab[i].size;
		stable.slab[i].num_free_objects = stable.slab[i].num_objects_per_page;
		stable.slab[i].num_used_objects = 0;
		stable.slab[i].bitmap = kalloc();
		memset(stable.slab[i].bitmap, 0, 4096);
		stable.slab[i].page[stable.slab[i].num_pages++] = kalloc();
	}
	//release(&stable.lock);
}

char *kmalloc(int size){
	if(size<0 || size>2048)
		return 0;
	
	char *addr = 0;
	struct slab *s = 0;

	//acquire(&stable.lock);


	for(s = stable.slab; s < &stable.slab[NSLAB]; s++){
		if(size <= s->size)
			break;
	}
		
	
	if(s->num_free_objects == 0){

		if(s->num_pages >= MAX_PAGES_PER_SLAB){
			//release(&stable.lock);
			return 0;
		}

		s->page[s->num_pages] = kalloc();


		if(s->page[s->num_pages] == 0){
			//release(&stable.lock);
			return 0;
		}
		
		s->num_pages++;
		s->num_free_objects += s->num_objects_per_page;
	}
		

	int len = s->num_pages * s->num_objects_per_page;
	for(int i=0; i<len; i++){
		if(!get_bit(s->bitmap, i)){
			int number = i / s->num_objects_per_page;
			int offset = i % s->num_objects_per_page;

			addr = s->page[number] + (offset * s->size);
			set_bit(s->bitmap, i);
			s->num_free_objects--;
			s->num_used_objects++;
			break;
		}
	}
	
	//release(&stable.lock);
	return addr;
}

void kmfree(char *addr, int size) {
    struct slab *s;

    //acquire(&stable.lock);

    for (s = stable.slab; s < &stable.slab[NSLAB]; s++) {
        if (size <= s->size)
            break;
    }

    int len = s->num_pages * s->num_objects_per_page;
    for (int i = 0; i < len; i++) {
        int number = i / s->num_objects_per_page;
        int offset = i % s->num_objects_per_page;

        if (addr == (s->page[number] + (offset * s->size))) {
   
            memset(addr, 0, s->size);
            s->num_free_objects++;
            s->num_used_objects--;

       
            clear_bit(s->bitmap, i);

         

            if (s->num_pages > 1 && s->num_used_objects == 0) {
      
                int full_number = -1;
                for (int j = 0; j < s->num_pages; j++) {
                    bool is_full = true;
                    for (int k = 0; k < s->num_objects_per_page; k++) {
                        int obj_index = j * s->num_objects_per_page + k;
                        if (get_bit(s->bitmap, obj_index) == 0) {
                            is_full = false;
                            break;
                        }
                    }
                    if (is_full) {
                        full_number = j;
                        break;
                    }
                }

                if (full_number != -1) {
         
                    for (int j = full_number * s->num_objects_per_page; j < (len - s->num_objects_per_page); j++) {
                        if (get_bit(s->bitmap, j + s->num_objects_per_page)) {
                            set_bit(s->bitmap, j);
                        } else {
                            clear_bit(s->bitmap, j);
                        }
                    }
                    clear_bit(s->bitmap, len - s->num_objects_per_page);

     
                    kfree(s->page[full_number]);
                    for (int j = full_number; j < (s->num_pages - 1); j++) {
                        s->page[j] = s->page[j + 1];
                    }
                    s->num_pages--;
                    s->num_free_objects -= s->num_objects_per_page;
                }
            }

            //release(&stable.lock);
            return;
        }
    }
	//release(&stable.lock);
    
}


void slabdump(){
	cprintf("__slabdump__\n");

	struct slab *s;

	cprintf("size\tnum_pages\tused_objects\tfree_objects\n");

	for(s = stable.slab; s < &stable.slab[NSLAB]; s++){
		cprintf("%d\t%d\t\t%d\t\t%d\n",
			s->size, s->num_pages, s->num_used_objects, s->num_free_objects);
	}
}


int numobj_slab(int slabid)
{
  return stable.slab[slabid].num_used_objects;
}




