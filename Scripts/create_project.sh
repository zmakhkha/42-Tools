#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 folder_name"
    exit 1
fi

folder_name=$1

# Create the main folder
mkdir -p "$folder_name"
cd "$folder_name"

# Create sub-folders
mkdir -p src headers

# Create the main.cpp file
touch src/main.cpp

# Create the Makefile
cat <<EOF > Makefile
NAME =
CC = c++
CXXFLAGS = -std=c++98 -Wall -Wextra -Werror

Hed =
SRC = src/main.cpp

OBJ = \$(SRC:.cpp=.o)

all: \$(NAME)

\$(NAME): \$(OBJ)
	\$(CC) \$(CXXFLAGS) \$(OBJ) -o \$(NAME)

%.o: %.cpp \$(Hed)
	\$(CC) \$(CXXFLAGS) -c \$< -o \$@

clean:
	rm -f \$(OBJ)

fclean: clean
	rm -f \$(NAME)

re: fclean all

.PHONY: clean fclean all re
EOF

echo "Folder structure, main.cpp, and Makefile created successfully."
