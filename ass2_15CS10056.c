#include "myl.h"


int printStr(char* a)
{
	int bytes=0,i;
	i=0;
	char* c=a;
	while((*c)!='\0')
	{
		i++;
		c++;
	}
	bytes=i+1;
	__asm__ __volatile__("movl $1,%%eax \n \t" "movq $1,%%rdi \n \t" "syscall \n \t" : :"S"(a),"d"(bytes));
	return (i+1);
}

int readInt(int *n)
{
	char buff[20];
	int bytes=20,i,num,j,k;
	__asm__ __volatile__("movl $0,%%eax \n \t" "movq $0,%%rdi \n \t" "syscall \n \t" : :"S"(buff),"d"(bytes));
	i=0;
	if(buff[i]=='-'||(buff[i]>='0'&&buff[i]<='9'))
	{
		if(buff[i]=='-')
		{
			i++;
		}
		while(buff[i]!='\n')
		{
			if(!(buff[i]>='0'&&buff[i]<='9'))
			{
				return ERR;
			}
			//printf("1");
			i++;
		}
	}
	else
	{
		return ERR;
	}
	i=0;
	num=0;
	k=1;
	if(buff[i]=='-')
	{
		i++;
		k=-1;
	}
	while(buff[i]!='\n')
	{
		j=(int)(buff[i]-'0');
		num=num*10+j;
		i++;
		//printf("1");
	}
	//num=num-(int)('\0'-'0');
	//num=num/10;
	num=num*k;
	(*n)=num;
	return OK;
}

int printInt(int n)
{
	int i,j,k,bytes,digit;
	i=0;
	char buff[20],zero='0',temp;
	if(n==0)
	{
		buff[i]='0';
		i++;
	}
	else
	{
		if(n<0)
		{
			buff[i]='-';
			i++;
			n=-n;
		}
		while(n>0)
		{
			digit=n%10;
			buff[i]=(char)('0'+digit);
			i++;
			n=n/10;
		}
		if(buff[0]=='-')
		{
			j=1;
		}
		else
		{
			j=0;
		}
		k=i-1;
		while(j<k)
		{
			temp=buff[j];
			buff[j]=buff[k];
			buff[k]=temp;
			j++;
			k--;
		}
	}
	buff[i]='\n';
	bytes=i+1;
	__asm__ __volatile__("movl $1,%%eax \n \t" "movq $1,%%rdi \n \t" "syscall \n \t" : :"S"(buff),"d"(bytes));
	return (i);
}

int readFlt(float *f)
{
	char buff[20];
	int bytes=20,i,j,k,l,neg=1,flag=0;
	float num=0.000000,temp=0.0;
	__asm__ __volatile__("movl $0,%%eax \n \t" "movq $0,%%rdi \n \t" "syscall \n \t" : :"S"(buff),"d"(bytes));
	i=0;
	if(buff[i]=='-'||buff[i]=='.'||(buff[i]>='0'&&buff[i]<='9'))
	{
		if(buff[i]=='-'||buff[i]=='.')
		{
			i++;
			if(buff[i]=='.')
			{
				flag=1;
			}
		}
		while(buff[i]!='\n')
		{
			if(!((buff[i]>='0'&&buff[i]<='9')||buff[i]=='.'))
			{
				return ERR;
			}
			else
			{
				if(buff[i]=='.')
				{
					if(flag==1)
					{
						return ERR;
					}
					flag=1;
				}
			}
			i++;
		}
	}
	else
	{
		return ERR;
	}
	i=0;
	j=0;
	if(buff[i]=='-')
	{
		i++;
		neg=-1;
	}
	while(buff[i]!='.'&&buff[i]!='\n')
	{
		k=(int)(buff[i]-'0');
		j=j*10+k;
		i++;
	}
	j=j*neg;
	num=j;
	i++;
	l=0;
	j=0;
	while(l<6&&buff[l+i]!='\n')
	{
		k=(int)(buff[l+i]-'0');
		j=j*10+k;
		l++;
	}
	/*while(l<6)
	{
		j=j*10;
		l++;
	}
	temp=j;
	temp=temp/1000000;
	num=num+temp;*/
	temp=j;
	while(l>0)
	{
		temp=temp/10;
		l--;
	}
	temp=temp*neg;
	num=num+temp;
	(*f)=num;
	return OK;
}

int printFlt(float f)
{
	int in,i,j,k,bytes,l,digit,temp;
	float dec;
	char buff[25];
	in=(int)f;
	f=f-in;
	char a[20];
	i=0;
	if(in==0)
	{
		buff[i]='0';
		i++;
	}
	else
	{
		if(in<0)
		{
			buff[i]='-';
			i++;
			in=-in;
		}
		while(in>0)
		{
			digit=in%10;
			buff[i]=(char)('0'+digit);
			i++;
			in=in/10;
		}
		if(buff[0]=='-')
		{
			j=1;
		}
		else
		{
			j=0;
		}
		k=i-1;
		while(j<k)
		{
			temp=buff[j];
			buff[j]=buff[k];
			buff[k]=temp;
			j++;
			k--;
		}
	}
	buff[i]='.';
	i++;
	//bytes=i+1;
	l=0;
	while(l<6)
	{
		digit=(int)(f*10);
		//dec=digit/10;
		buff[i]=(char)('0'+digit);
		f=f*10;
		f=f-digit;
		l++;
		i++;
	}
	buff[i]='\n';
	bytes=i+1;
	__asm__ __volatile__("movl $1,%%eax \n \t" "movq $1,%%rdi \n \t" "syscall \n \t" : :"S"(buff),"d"(bytes));
	return (i);
}
