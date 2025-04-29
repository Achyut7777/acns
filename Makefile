default:
	env | grep "[QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF][QWERTYUIOPLKJHGF]" | md5sum | sha256sum | python3 xor.py in.bin out.bin
	strings -wn 40 out.bin | grep -v "KOA\[" | tr -d '\014-\015' > chooseyourfighter.red
	rm out.bin

clean:
	rm -f out.bin
	rm -f *.red
