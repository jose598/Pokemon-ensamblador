#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int main(int argc, char **argv){

	FILE *fp=stdin;
	char buf[10000];
	char *file="pokeTypes.txt";
	int nramdon,nPoke1,nPoke2;
	int cont=1;
	int num=0;
	
int PokeAttack[18][18] = {{1,1,1,1,1,0.5,1,0,0.5,1,1,1,1,1,1,1,1,1},
			{2,1,0.5,0.5,1,2,0.5,0,2,1,1,1,1,0.5,2,1,2,0.5},
			{1,2,1,1,1,0.5,2,1,0.5,1,1,2,0.5,1,1,1,1,1},
			{1,1,1,0.5,0.5,0.5,1,0.5,0,1,1,2,1,1,1,1,1,2},
			{1,1,0,2,1,2,0.5,1,2,2,1,0.5,2,1,1,1,1,1},
			{1,0.5,2,1,0.5,1,2,1,0.5,2,1,1,1,1,2,1,1,1},
			{1,0.5,0.5,0.5,1,1,1,0.5,0.5,0.5,1,2,1,2,1,1,2,0.5},
			{0,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,1},
			{1,1,1,1,1,2,1,1,0.5,0.5,0.5,1,0.5,1,2,1,1,2},
			{1,1,1,1,1,0.5,2,1,2,0.5,0.5,2,1,1,2,0.5,1,1},
			{1,1,1,1,2,2,1,1,1,2,0.5,0.5,1,1,1,0.5,1,1},
			{1,1,0.5,0.5,2,2,0.5,1,0.5,0.5,2,0.5,1,1,1,0.5,1,1},
			{1,1,2,1,0,1,1,1,1,1,2,0.5,0.5,1,1,0.5,1,1},
			{1,2,1,2,1,1,1,1,0.5,1,1,1,1,0.5,1,1,0,1},
			{1,1,2,1,2,1,1,1,0.5,0.5,0.5,2,1,1,0.5,2,1,1},
			{1,1,1,1,1,1,1,1,0.5,1,1,1,1,1,1,2,1,0},
			{1,0.5,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,0.5},
			{1,2,1,0.5,1,1,1,1,0.5,0.5,1,1,1,1,1,2,2,1}};

printf("Bienvenido al sistema de combates Pokémon: \n");
srand(time(NULL));
nramdon = rand()%(99-1+1) + 1;
printf("ramdon: %d\n",nramdon);
fp=fopen(file,"r");
while(!feof(fp) && num<10){
	if((fscanf(fp,"%s",buf)>0)){
			if(cont==nramdon){
			printf("%s\n",buf);
			num++;
			}else if (num>=1){ printf("%s\n",buf); num++;}
		cont++;
	}

}
//printf("\nIngrese el número del primer Pokémon para el combate: ");
//scanf("%d",&nPoke1);
//printf("\nIngrese el número del segundo Pokémon para el combate: ");
//scanf("%d",&nPoke2);
}
