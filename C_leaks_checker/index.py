# to replace in header
'''
static void *_malloc(size_t c, char *file, int line)
{
	void *p = malloc(c);
	printf("MALC: %p, LINE = %i, FILE = %s\n", p, line, file);
	return (p);
}

static void _free(void* c, char *file, int line)
{
	printf("FREE: %p, LINE = %i, FILE = %s\n", c, line, file);
	return (free(c));
}

#define malloc(c) _malloc(c, __FILE__, __LINE__)
#define free(c) _free(c, __FILE__, __LINE__)
'''

allocated = {}
freed = {}

# Read input from a file
filename = 'leaks'
with open(filename, 'r') as file:
    file_content = file.read()

for line in file_content.split('\n'):
    line = line.strip()
    if not line:
        continue
    if not (line.startswith("FREE") or line.startswith("MALC")):
        continue
    pointer = line.split(' ')[1][:-1]
    _type = line.split(' ')[0][:-1]

    if _type == "FREE":
        freed[pointer] = 1
    if _type == "MALC":
        allocated[pointer] = line


for key in freed:
    allocated[key] = 0

for key, value in allocated.items():
    if value != 0:
        print(value)
