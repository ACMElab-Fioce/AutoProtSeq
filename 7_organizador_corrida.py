import argparse

# Função para processar o arquivo de entrada e criar o arquivo de saída
def processar_arquivo(entrada, saida):
    with open(entrada, 'r') as arquivo_entrada, open(saida, 'w') as arquivo_saida:
        for linha in arquivo_entrada:
            
            linha = linha.replace("| SequencingStatsCompact.", "")
            linha = linha.replace(" | ", "\t")
            linha = linha.replace("|", "")
            linha = linha.replace(" ", "")
            arquivo_saida.write(f"{linha}")

def main():
    # Configurar o parser de argumentos
    parser = argparse.ArgumentParser(description='Processa um arquivo de entrada e cria um arquivo de saída no formato desejado.')
    parser.add_argument('-i', '--input', type=str, required=True, help='Caminho do arquivo de entrada')
    parser.add_argument('-o', '--output', type=str, required=True, help='Caminho do arquivo de saída')

    # Parse dos argumentos
    args = parser.parse_args()

    # Chamar a função para processar o arquivo
    processar_arquivo(args.input, args.output)

    print(f"O arquivo '{args.output}' foi criado com sucesso.")

if __name__ == "__main__":
    main()
