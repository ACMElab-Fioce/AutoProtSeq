from PIL import Image  # install by > python3 -m pip install --upgrade Pillow  # ref. https://pillow.readthedocs.io/en/latest/installation.html#basic-installation
import os
import PyPDF2

arquivos = os.listdir()

if "imagens" not in arquivos:
    os.mkdir("imagens")
else:
    arquivos_imagens = os.listdir(os.path.join(os.getcwd(), "imagens"))
    if len(arquivos_imagens) > 0:
        for arquivo_imagem in arquivos_imagens:
            diretorio_imagem = os.path.join(os.getcwd(), "imagens", arquivo_imagem)
            os.remove(diretorio_imagem)


lista_imagens = [imagem for imagem in arquivos if imagem.endswith(".jpg")]

images = [
    Image.open(f"{f}")
    for f in lista_imagens
]

pdf_path = "graficos_relatorio.pdf"
    
images[0].save(
    pdf_path, "PDF" ,resolution=100.0, save_all=True, append_images=images[1:]
)
                       

for imagem in lista_imagens:
    os.rename(imagem, os.path.join(os.getcwd(), "imagens", imagem))