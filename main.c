#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#define NUMBER 100

//valida num entre 1 y 10
int valOpcion(int n){
    if(n<1 || n>11){
	return 0;
    }else{
	return -1;}
}

int validarSalida(int n){
	if(n==11) printf("Gracias por jugar, Saliendo.... \n");
	return 0;
}

int valNum(int num){
	if(scanf("%d",&num)==0){
		for (int c=getchar(); c!=EOF && c!=' ' && c!='\n'; c=getchar());
		return 0;	
	}
	return -1;
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

int **pokemones(char **lectura, char **pokemons,char **tipos){

	char *p;

	for (int i=0; i<10;i++){
 		p=strtok(lectura[i],",");
		 if(p!=NULL){
			pokemons[i]=p;
				 p=strtok(NULL," ");
				 if(p!=NULL) {
				 tipos[i]=p;
			   }
		 }
	}
	p="Salir";
	pokemons[10]=p;
	return 0;

}
int posicionSkin(char* Pokeskin[18],char* tipo){
	
	for (int i=0; i<19;i++){
		if(strcmp(Pokeskin[i],tipo) == 0){
			return i;
		}	
	}return 0;
}


int batalla(int vidaA,int vidaD, int ataqueA, int ataqueD,char* pokeA,char* pokeD,int formato){
	printf("\n\n %s:Vida:%d Ataque:%d ataca a %s: Vida: %d Ataque: %d",pokeA,vidaA,ataqueA,pokeD,vidaD,ataqueD);
	vidaD=vidaD-ataqueA;
	if(vidaD<0){
		vidaD=0;
	}
	
	printf("\n resultado del ataque");
	if(formato==0){
	printf("\n %s:Vida:%d Ataque:%d ",pokeA,vidaA,ataqueA);
	printf("\n %s:Vida:%d Ataque:%d ",pokeD,vidaD,ataqueD);
	return vidaD;
	}else{
		printf("\n %s:Vida:%d Ataque:%d ",pokeD,vidaD,ataqueD);
	    printf("\n %s:Vida:%d Ataque:%d ",pokeA,vidaA,ataqueA);
		return vidaA;
	}
    return -1;
}


int main(int argc, char **argv){
	char error[]="\nError,por favor ingrese un número válido(1 al 11): ";
	char ingreso1[]="\nIngrese el número del primer Pokémon para el combate: ";
	char ingreso2[]="\nIngrese el número del segundo Pokémon para el combate: ";
	int nramdon,nPoke1,nPoke2;
	char* tipoP1;
	char* tipoP2;
	char* poke1;
	char* poke2;
	int base=2;
	int vidaP1=5;
        int vidaP2=5;
	char **pokemons=(char **)malloc(NUMBER);
    char **tipos=(char **)malloc(NUMBER);
	
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
char* Pokeskin[18] ={"normal","fighting","flying","poison","ground","rock","bug","ghost","steel","fire","water","grass","electric","psychic","ice","dragon","dark","fary"};

	


printf("Bienvenido al sistema de combates Pokémon:\n");
srand(time(NULL));
nramdon = rand()%(99-1+1) + 1;
char **leer=lectura(nramdon);

pokemones(leer,pokemons,tipos);
for(int i=0;i<11;i++) printf("%d. %s\n",i+1,pokemons[i]);

printf("%s",ingreso1);
scanf("%d",&nPoke1);
if(nPoke1==11){ 
	printf("Saliendo...\n");
	return 0;	
}
while((valOpcion(nPoke1)==0) ){
	printf("%s",error);
	scanf("%d",&nPoke1);
}

printf("%s",ingreso2);
scanf("%d",&nPoke2);

if(nPoke2==11){ 
	printf("Saliendo...\n");
	return 0;	
}
while((valOpcion(nPoke2)==0) ){
	printf("%s",error);
	scanf("%d",&nPoke2);
}

poke1= pokemons[nPoke1-1];
poke2= pokemons[nPoke2-1];
tipoP1=tipos[nPoke1-1];
tipoP2=tipos[nPoke2-1];
int tipo1=posicionSkin(Pokeskin,tipoP1);
int tipo2=posicionSkin(Pokeskin,tipoP2);
int ataqueP1=PokeAttack[tipo2][tipo1];
int ataqueP2=PokeAttack[tipo1][tipo2];
ataqueP1=base*ataqueP1;
ataqueP2=base*ataqueP2;
//printf("\nt:%s a:%d ",tipoP1,ataqueP1);
//printf("\nt:%s a:%d ",tipoP2,ataqueP2);

//batalla
printf("\nCombatientes: %s vs %s\n",poke1,poke2);

while(vidaP2!=0 && vidaP1!=0){
vidaP2=batalla(vidaP1,vidaP2, ataqueP1,ataqueP2, poke1, poke2,0);
if(vidaP2==0){
		printf("\n¡%s es el ganador!\n",poke1);
		return 0;
		}
vidaP1=batalla(vidaP2,vidaP1, ataqueP2,ataqueP1, poke2, poke1,1);
	if(vidaP1==0){
		printf("\n¡%s es el ganador!\n",poke2);
		return 0;
		}
	}
}
