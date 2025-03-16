# icache

## cache miss --> line fill buffer --> way allocation

![screenshot0](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate0.png)

![screenshot1](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate1.png)


-----------------------
16KB L1 instruction cache

The L1 icache is 2-way set associative with a 32-byte (256-bit) line size, line fill block is also 32-byte. There are 256 sets in each cacheand each set contains two ways. Cache lines are fetched from main memory using a burst bus transaction of four quadwords (64-bit).


32-byte x 256-set x 2-way = 16KB


Each way has a 22-bit tag ram and 4 64-bit data ram.


`````c
 32-bit address
 
    |____________________|___________|
   31       tag        11 10         0
`````


`````c

 8-bit index, 256 sets   (10-bit address, but only 8 bits are actually used)

 tag ram index

 ifu_icu_addr_ic1[14:5]


 data ram index, last 2-bit addresses ram line

 {ic_lu_addr_ic2[14:5], al_cnt_q[1:0]}
`````

````c

 tag ram 22-bit, [21] v, [20:0] tag

   v
  |_|____________________|
 21 20      tag          0


 data ram 64-bit

    |______________________________________________________________________|
   63                                data                                  0
`````
