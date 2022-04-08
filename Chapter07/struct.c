#include <stdio.h>

struct TimeZone {
  int minutes_west;
  int dst_time;
};

void print_tz(struct TimeZone *tz)
{
  printf("DST time is: %d\n", tz->dst_time);
}
