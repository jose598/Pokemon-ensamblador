#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#define NUMBER 100

//valida num entre 1 y 4
int valOpcion(int n){
    if(n<1 || n>4)
	return 0;
     else
	return 1;
}
int valNum(int num){
	if(scanf("%d",&num)==0){
		for (int c=getchar(); c!=EOF && c!=' ' && c!='\n'; c=getchar());
		return 0;	
	}
	return 1;
}

char **lectura (int nramdon){
	char **pokemenu=(char **)malloc(NUMBER);
	FILE *fp;
	char *file="pokeTypes.txt";
	int cont=1;
	int num=0;
	fp=fopen(file,"r");
	while(!feof(fp) && num<10){
		char buf[10000];
	if((fscanf(fp,"%s",buf)>0)){
			if(cont==nramdon){
				char *p=(char *)malloc(NUMBER);
				strcpy(p,buf);
				pokemenu[num]=p;
				num++;
			}else if (num>=1){
				char *p=(char*)malloc(NUMBER);
				strcpy(p,buf);
				pokemenu[num]=p;
				num++;
			}
		cont++;
		}
	}
return pokemenu;
}

char **pokemones(char **lectura, int identificador){
	char **pokeOpciones=(char **)malloc(NUMBER);
	char **pokePoderes=(char **)malloc(NUMBER);
	char *p;
	for (int i=0; i<10;i++){
 		p=strtok(lectura[i],",");
		if(p!=NULL){
			char *puntero=(char *)malloc(NUMBER);
			strcpy(puntero,p);
			pokeOpciones[i]=puntero;	
			p=strtok(NULL," ");
			if(p!=NULL) {
				char *puntero=(char *)malloc(NUMBER);
				strcpy(puntero,p);
				pokePoderes[i]=puntero;
			}
		}
	}
	if(identificador==0) return pokeOpciones;
	return pokePoderes;

}



int main(int argc, char **argv){

	FILE *fp=stdin;
	char buf[10000];
	char *file="pokeTypes.txt";
	char ingreso1[]="\nIngrese el número del primer Pokémon para el combate: ";
	char ingreso2[]="\nIngrese el número del segundo Pokémon para el combate: ";
	char error[]="\nError,por favor ingrese un número válido(1 al 4): ";
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



printf("Bienvenido al sistema de combates Pokémon:\n");
srand(time(NULL));
nramdon = rand()%(99-1+1) + 1;
char **leer=lectura(nramdon);
//char **pokemons=pokemones(leer,0);
char **tipos=pokemones(leer,1);
//for(int i=0;i<10;i++) printf("%d. %s\n",i+1,pokemons[i]);
for(int j=0;j<10;j++) printf("%d. %s\n",j+1,tipos[j]);


printf("%s",ingreso1);
scanf("%d",&nPoke1);
while((valOpcion(nPoke1)==0) && (valNum(nPoke1)==0)){
	printf("%s",error);
	scanf("%d",&nPoke1);
}
printf("%s",ingreso2);
scanf("%d",&nPoke2);

while((valOpcion(nPoke2)==0) && (valNum(nPoke2)==0)){
	printf("%s",error);
	scanf("%d",&nPoke2);
}
}
