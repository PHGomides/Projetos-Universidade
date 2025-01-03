package model;
public class Cliente {
    public static String[] vetdia, vetproteina, vetvegano, vetsalada, vetfruta, vetsuco;
    public int dia;

    //Construtor vazio para inserir informações padrões do cardapio
    public Cliente(){
        vetdia = new String[5];
        vetproteina = new String[5];
        vetvegano = new String[5];
        vetsalada = new String[5];
        vetsuco = new String[5];
        vetfruta = new String[5];

        vetdia[0] = new String("Segunda-Feira");
        vetdia[1] = new String("Terça-Feira");
        vetdia[2] = new String("Quarta-Feira");
        vetdia[3] = new String("Quinta-Feira");
        vetdia[4] = new String("Sexta-Feira");

        vetproteina[0] = new String("Frango Assado"); 
        vetproteina[1] = new String("Feijoada"); 
        vetproteina[2] = new String("Carne Assada"); 
        vetproteina[3] = new String("Carne de porco"); 
        vetproteina[4] = new String("Escondidinho de frango");

        vetvegano[0] = new String("Berinjela Defumada"); 
        vetvegano[1] = new String("Carne de soja"); 
        vetvegano[2] = new String("Nhoque de Abóbora"); 
        vetvegano[3] = new String("Caçarola de Abobrinha"); 
        vetvegano[4] = new String("Empanada de Escarola");

        vetsalada[0] = new String("Alface e tomate"); 
        vetsalada[1] = new String("Alface e beterraba"); 
        vetsalada[2] = new String("Alface e cenoura"); 
        vetsalada[3] = new String("Alface e repolho"); 
        vetsalada[4] = new String("Alface e pepino");

        vetfruta[0] = new String("Banana"); 
        vetfruta[1] = new String("Maça"); 
        vetfruta[2] = new String("Laranja"); 
        vetfruta[3] = new String("Melão"); 
        vetfruta[4] = new String("Melancia");

        vetsuco[0] = new String("Uva"); 
        vetsuco[1] = new String("Laranja"); 
        vetsuco[2] = new String("Manga"); 
        vetsuco[3] = new String("Limão"); 
        vetsuco[4] = new String("Tangerina");
    }
    //-------------------------------------------------------------------------------------------------------------------------------------------------------



    // ULIZAÇÃO DO BUILDER
    //Contrutor usado para altera as informações do cardapio utilizando o padrão builder
    public Cliente(int dia, String proteina, String vegano, String salada, String fruta, String suco){
        this.dia = dia;
        this.vetproteina[dia]= proteina;
        this.vetvegano[dia] = vegano;
        this.vetsalada[dia] = salada;
        this.vetfruta[dia] = fruta;
        this.vetsuco[dia] = suco;
    }


    //Padrão de projeto Builder
    public static class ClienteBuilder{
         public static String infoproteina, infovegano, infosalada, infofruta, infosuco;
         public  int infodia;

          public ClienteBuilder altdia(int dia){
              this.infodia = dia;
              return this;
          }

         public ClienteBuilder altproteina(String vetproteina){
            this.infoproteina = vetproteina;
            return this;
        }
        public ClienteBuilder altvegano(String vetvegano){
            this.infovegano = vetvegano;
            return this;
        }
        public ClienteBuilder altsalada(String vetsalada){
            this.infosalada = vetsalada;
            return this;
        }
        public ClienteBuilder altfruta(String vetfruta){
            this.infofruta = vetfruta;
            return this;
        }
        public ClienteBuilder altsuco(String vetsuco){
            this.infosuco = vetsuco;
            return this;
        }

        public Cliente builder(){
            return new Cliente(infodia, infoproteina, infovegano, infosalada, infofruta, infosuco);
        }
    }
}
