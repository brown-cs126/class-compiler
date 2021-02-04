#include <stdio.h>
#include <inttypes.h>

extern uint64_t entry();

#define num_shift 2
#define num_mask 0b11
#define num_tag 0b00

void print_value(uint64_t value) {
  if ((value & num_mask) == num_tag) {
    int64_t ivalue = (int64_t)value;
    printf("%" PRIi64, ivalue >> num_shift);
  }
}

int main(int argc, char **argv) {
  print_value(entry());
  return 0;
}