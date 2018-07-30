CFLAGS=-D_FILE_OFFSET_BITS=64

linux64:	mine mine_pool_all mine_pool_share

linux32:	mine32 mine_pool_all32 mine_pool_share32

all:		linux64 linux32

dist:		linux64 linux32
		mkdir -p bin
		rm -f bin/* shabal64.o shabal32.o dcct_miner.tgz
		mv mine mine32 mine_* bin
		tar -czf dcct_miner.tgz *

mine:		mine.c shabal64.o helper64.o mshabal_sse4.o
		gcc -Wall -m64 -O2 -DSOLO -o mine mine.c shabal64.o helper64.o mshabal_sse4.o -lpthread

mine_pool_all:	mine.c shabal64.o helper64.o mshabal_sse4.o
		gcc -Wall -m64 -O2 -DURAY_POOL -o mine_pool_all mine.c shabal64.o helper64.o mshabal_sse4.o -lpthread

mine_pool_share:	mine.c shabal64.o helper64.o mshabal_sse4.o
		gcc -Wall -m64 -O2 -DSHARE_POOL -o mine_pool_share mine.c shabal64.o helper64.o mshabal_sse4.o -lpthread

mine32:		mine.c shabal32.o helper32.o mshabal_sse432.o
		gcc -Wall -m32 -O2 -DSOLO -o mine32 mine.c shabal32.o helper32.o mshabal_sse432.o -lpthread

mine_pool_all32:	mine.c shabal32.o helper32.o mshabal_sse432.o
		gcc -Wall -m32 -O2 -DURAY_POOL -o mine_pool_all32 mine.c shabal32.o helper32.o mshabal_sse432.o -lpthread

mine_pool_share32:	mine.c shabal32.o helper32.o mshabal_sse432.o
		gcc -Wall -m32 -O2 -DSHARE_POOL -o mine_pool_share32 mine.c shabal32.o helper32.o mshabal_sse432.o -lpthread

helper64.o:	helper.c
		gcc -Wall -m64 -c -O2 -o helper64.o helper.c

helper32.o:	helper.c
		gcc -Wall -m32 -c -O2 -o helper32.o helper.c

shabal64.o:	shabal64.s
		gcc -Wall -m64 -c -O2 -o shabal64.o shabal64.s

shabal32.o:	shabal32.s
		gcc -Wall -m32 -c -o shabal32.o shabal32.s

mshabal_sse4.o: mshabal_sse4.c
		gcc -Wall -m64 -c -O2 -march=native -o mshabal_sse4.o mshabal_sse4.c

mshabal256_avx2.o: mshabal256_avx2.c
		gcc -Wall -m64 -c -O2 -march=native -mavx2 -o mshabal256_avx2.o mshabal256_avx2.c

mshabal_sse432.o: mshabal_sse4.c
		gcc -Wall -m32 -c -O2 -march=native -o mshabal_sse432.o mshabal_sse4.c

clean:
		rm -f mshabal_sse432.o mshabal_sse4.o mshabal256_avx2.o shabal64.o shabal32.o helper64.o helper32.o mine mine32 mine_pool_all mine_pool_all32 mine_pool_share mine_pool_share32 helper32.o helper64.o dcct_miner.tgz
