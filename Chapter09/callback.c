#include <stdlib.h>
#include <time.h>

void number_callback(void (*callback)(int))
{
  srand(time(0));
  return (*callback)(rand());
}
