import sys

filename = sys.argv[1]
file = open(filename)
k = 0
is_mul = True
for i in file.readlines():
    while len(i) > 8:
        if i.startswith("mul") and is_mul:
            mul_line = i[: i.find(")") + 1]
            try:
                int_1 = int(mul_line[4 : mul_line.find(",")].strip())
                int_2 = int(
                    mul_line[mul_line.find(",") + 1 : mul_line.find(")")].strip()
                )
                k += int_1 * int_2
            except:
                pass
        if i.startswith("do()"):
            is_mul = True

        if i.startswith("don't()"):
            is_mul = False

        i = i[1:]
print(k)
