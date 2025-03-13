# icache

## cache miss --> line fill buffer --> way allocation

![screenshot0](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate0.png)

![screenshot1](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate1.png)


-----------------------
256-bit cache line

2 ways, each way has a 22-bit tag ram and 4 64-bit data ram.


`````c
 32-bit address
 
    |____________________|___________|
   31       tag        11 10         0
`````


`````c

 10-bit index, 1024 sets

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
