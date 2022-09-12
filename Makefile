
TARGET = file

CC = gcc
SRC_DIR = src
OBJ_DIR = build

SRC_FILES = $(shell find $(SRC_DIR) -type f -name "*.c")
OBJ_FILES = $(patsubst $(SRC_DIR)%.c,$(OBJ_DIR)%.o,$(SRC_FILES))
DEP_FILES = $(patsubst $(SRC_DIR)%.c,$(OBJ_DIR)%.d,$(SRC_FILES))

OBJ_SUBDIRS = $(shell find $(SRC_DIR) -type d | sed -E 's/^$(SRC_DIR)/$(OBJ_DIR)/')

.PHONY: clean all

CFLAGS += -Wall -Wextra -pedantic -I src/ -std=c11
LDFLAGS += # LINK LIBS HERE

all: $(TARGET)

-include $(DEP_FILES)

$(TARGET): $(OBJ_SUBDIRS) $(OBJ_FILES)
	$(CC) $(OBJ_FILES) $(LDFLAGS) -o $@ 

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -MMD -MD $(CFLAGS) -c $< -o $@ 

$(OBJ_SUBDIRS):
	mkdir -p $@

clean:
	rm -rf $(OBJ_SUBDIRS)


