#include <stdio.h>
#include <stdlib.h>
//#include <string.h>
#include <math.h>
#include <time.h>
//adriann_programming_problems_Elementary

//1-3

int main ()
{
  printf("Hello,world.\n");
  printf("May I ask your name?\n");

  const char name1[] = "Alice";
  const char name2[] = "Bob";
  char name[] = "";

  scanf("%s",name);

  int c1 = strcmp(name,name1);
  int c2 = strcmp(name,name2);

  //test printf("%d,%d\n",c1, c2);
  if ((c1 + c2) == 0)
    {
      printf("Nice to meet you:) %s.\n",name);
    }
  else
    return 0;
}

//4-5

int main ()
{

  float intp(float number)
  {
    if(floor(number) == number)
      {
        return 1;
      }
    else
      return 0;
  }

  printf("Give me a number:\n");
  int number;

  scanf("%d",&number);

  float t3 = (float)number / 3,
    t5 = (float)number / 5;

  //  printf("%f",intp(t3) + intp(t5));
  if((intp(t3) + intp(t5)
      >= 1))
    {
      printf("%d",number + 1);
    }
  else
    return 0;
}

//6

int main ()
{
  long long n,n2;
  char opt = '~';

  //printf("%lld",LONG_LONG_MAX);
  printf("\nGive me a number:");
  scanf("%lld",&n);

 label:
  {
    printf("\n(%lld ==> Type:s-sum p-product q-quit):",n);
    getchar();
    scanf("%c",&opt);
  }

  switch(opt)
    {
    case 's':
      {
        printf("%lld + 'give me another number:\n",n);
        scanf("%lld",&n2);
        printf("%lld",n + n2);
        goto label;
        break;
      }
    case 'p':
      {
        printf("%lld * 'give me another number:\n",n);
        scanf("%lld",&n2);
        printf("%lld",n * n2);
        goto label;
        break;
      }
    case 'q':return 0;
    default:
      {
        printf("Error,retry!");
        goto label;
      }

    }

  return 0;
}

//7

int main ()
{
  long long input;
  printf("Give me a number:");
  scanf("%lld",&input);

  for(int i = 1; i <= 12; i++)
    {
      printf("%lld * %d = %lld\n",input, i,input * (i + 0));
    }

  return 0;
}

//8

int main ()
{
  bool primep(long long n)
  {
    if(n < 2) return false;
    for (long long i = 2; i <= sqrt(n); i++)
      {
        if (n % i == 0)
          return false;
      }
    return true;
  }

  for (long long i = sqrt(LONG_LONG_MAX); i >= LONG_MAX; i--)
    {
      if(primep(i))
        {
          printf("%lld\n", i);
        }

    }
  return 0;
}

//9

int main ()
{
  srand(time(NULL));
  int result = rand()%100;
  int guess;

 label:{
    //    printf("%d\n",result);
    printf("Guess the secret number(max=100):\n\n");

    scanf("%d",&guess);
  }
  if(guess == result)
    {
      printf("Correct! %d = %d \n\n",guess,result);
      return 0;
    }
  else if (guess > result)
    {
      //printf("%d\n",result);
      printf("Too large,try again.\n\n");
      goto label;
    }
  else if (guess < result)
    {
      //printf("%d\n",result);
      printf("Too small,try again.\n\n");
      goto label;
    }
  return 0;
}

//10

int main ()
{
  float intp(float number)
  {
    if(floor(number) == number)
      {
        return 1;
      }
    else
      return 0;
  }

  int k3 = 2026 + (21 * 4);
  for (int y = 2026; y <= k3; y++)
    {
      float leap = (float)y/4,
        leap1 = (float)y/400,
        notleap = (float)y/100;
      if((intp(leap) + intp(leap1)- intp(notleap)) > 0)
        printf("4的倍數但非100的倍數=%f, 400的倍數=%f, 閏日=%d\n",intp(leap), intp(leap1), y);
    }
  return 0;
}

//11

int main ()
{
  long long k;

  printf("Give me a number:");
  scanf("%lld",&k);

  double upperK = (pow(-1,((long long)k + 1)));
  double lowerK = ((2 * (long long)k) - 1);

  printf("%.15lf",(4 *  (upperK / lowerK) ));

  return 0;
}
//Elementary ends here

//non-related

#define TRUTH 42

enum date {YEAR = 1989, MONTH = 6, DAY = 4};
int n;

int main (void) {
  printf("%d %d %d\n",YEAR, MONTH, DAY);
  return 0;
}
