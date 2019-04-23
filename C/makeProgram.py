from bitstring import BitArray

c = BitArray(filename='program.bin')
i = 0

while len(c) != 0 :
	
	d = c[0:32]
	d.byteswap()
	c = c[32:]
	print (str(i) + '=>"' + d.bin + '",')
	i = i + 1
	