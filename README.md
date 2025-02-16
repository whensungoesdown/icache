# icache

## cache miss --> line fill buffer --> way allocation

![screenshot0](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate0.png)

![screenshot1](https://github.com/whensungoesdown/icache/blob/main/doc/png/cache_miss_allocate1.png)


-----------------------
16KB L1 instruction cache

256-bit cache line

2-way set associative, each way has a 22-bit tag ram and 4 64-bit data ram.


`````c
 32-bit address

    |____________________|___________|
   31       tag        11 10         0
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
