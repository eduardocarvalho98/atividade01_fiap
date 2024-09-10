import csv

culturas = []
areas_soja = []
areas_cacau = []
insumos_soja = []
insumos_cacau = []


def calcular_area(cultura):
    try:
        if cultura == "Soja":
            lado = float(input("Digite o comprimento do lado do quadrado (em metros): "))
            return lado * lado
        elif cultura == "Cacau":
            base = float(input("Digite a base do triângulo (em metros): "))
            altura = float(input("Digite a altura do triângulo (em metros): "))
            return 0.5 * base * altura
    except ValueError:
        print("Entrada inválida. Por favor, insira um número válido.")
        return calcular_area(cultura)


def calcular_insumos(cultura, area):
    insumo_por_metro = 50 if cultura == "Soja" else 30  # Soja: 50 kg/m², Cacau: 30 kg/m²
    return area * insumo_por_metro


def exportar_dados_csv():
    with open("dados_culturas.csv", mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["Cultura", "Área (m²)", "Qtd. de Cloreto de Potássio (KCl) (kg)"])

        # Adiciona dados de soja
        for area_soja, insumo_soja in zip(areas_soja, insumos_soja):
            writer.writerow(["Soja", area_soja, insumo_soja])

        # Adiciona dados de cacau
        for area_cacau, insumo_cacau in zip(areas_cacau, insumos_cacau):
            writer.writerow(["Cacau", area_cacau, insumo_cacau])

    print("\nDados exportados com sucesso para 'dados_culturas.csv'.")


def mostrar_menu():
    print("\nMenu de opções:")
    print("1. Entrada de dados")
    print("2. Saída de dados")
    print("3. Deletar dados")
    print("4. Atualizar dados")
    print("5. Exportar dados para CSV")
    print("6. Sair")


while True:
    mostrar_menu()
    try:
        opcao = int(input("Escolha uma opção: "))
    except ValueError:
        print("Entrada inválida. Por favor, escolha uma opção válida.")
        continue

    if opcao == 1:  # Entrada de dados
        cultura = input("Escolha uma cultura (Soja ou Cacau): ")
        if cultura in ["Soja", "Cacau"]:
            area = calcular_area(cultura)
            insumo = calcular_insumos(cultura, area)

            if cultura == "Soja":
                areas_soja.append(area)
                insumos_soja.append(insumo)
                print(f"\nEntradas para Soja até o momento:")
                for i, (area_soja, insumo_soja) in enumerate(zip(areas_soja, insumos_soja), start=1):
                    print(f"{i}. Área: {area_soja} m², KCl: {insumo_soja} kg")

            elif cultura == "Cacau":
                areas_cacau.append(area)
                insumos_cacau.append(insumo)
                print(f"\nEntradas para Cacau até o momento:")
                for i, (area_cacau, insumo_cacau) in enumerate(zip(areas_cacau, insumos_cacau), start=1):
                    print(f"{i}. Área: {area_cacau} m², KCl: {insumo_cacau} kg")

            culturas.append(cultura)
            print(f"\nDados inseridos para {cultura}:")
            print(f"Área: {area} m²")
            print(f"Qtd. de Cloreto de Potássio (KCl) necessário: {insumo} kg")
        else:
            print("Cultura não encontrada.")

    elif opcao == 2:  # Saída de dados
        print("\nDados inseridos:")
        soja_count, cacau_count = 0, 0
        for i, cultura in enumerate(culturas, start=1):
            if cultura == "Soja":
                soja_count += 1
                if soja_count <= len(areas_soja):
                    print(
                        f"{soja_count}. Cultura: {cultura}, Área: {areas_soja[soja_count - 1]} m², Qtd. de Cloreto de Potássio (KCl) necessário: {insumos_soja[soja_count - 1]} kg")
            elif cultura == "Cacau":
                cacau_count += 1
                if cacau_count <= len(areas_cacau):
                    print(
                        f"{cacau_count}. Cultura: {cultura}, Área: {areas_cacau[cacau_count - 1]} m², Qtd. de Cloreto de Potássio (KCl) necessário: {insumos_cacau[cacau_count - 1]} kg")

    elif opcao == 3:  # Deletar dados
        cultura = input("Escolha a cultura para deletar os dados (Soja ou Cacau): ")
        if cultura == "Soja" and len(areas_soja) > 0:
            print("\nEntradas de Soja:")
            for i, (area_soja, insumo_soja) in enumerate(zip(areas_soja, insumos_soja), start=1):
                print(f"{i}. Área: {area_soja} m², KCl: {insumo_soja} kg")
            try:
                posicao = int(input("Escolha a posição para deletar: ")) - 1
                if 0 <= posicao < len(areas_soja):
                    areas_soja.pop(posicao)
                    insumos_soja.pop(posicao)
                    culturas.remove("Soja")
                    print("\nDados de Soja deletados.")
                else:
                    print("Posição inválida.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número válido.")
        elif cultura == "Cacau" and len(areas_cacau) > 0:
            print("\nEntradas de Cacau:")
            for i, (area_cacau, insumo_cacau) in enumerate(zip(areas_cacau, insumos_cacau), start=1):
                print(f"{i}. Área: {area_cacau} m², KCl: {insumo_cacau} kg")
            try:
                posicao = int(input("Escolha a posição para deletar: ")) - 1
                if 0 <= posicao < len(areas_cacau):
                    areas_cacau.pop(posicao)
                    insumos_cacau.pop(posicao)
                    culturas.remove("Cacau")
                    print("\nDados de Cacau deletados.")
                else:
                    print("Posição inválida.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número válido.")
        else:
            print("Cultura não encontrada ou sem dados para deletar.")

    elif opcao == 4:  # Atualizar dados
        cultura = input("Escolha uma cultura para atualizar (Soja ou Cacau): ")
        if cultura == "Soja" and len(areas_soja) > 0:
            print("\nEntradas de Soja:")
            for i, (area_soja, insumo_soja) in enumerate(zip(areas_soja, insumos_soja), start=1):
                print(f"{i}. Área: {area_soja} m², KCl: {insumo_soja} kg")
            try:
                posicao = int(input("Escolha a posição para atualizar: ")) - 1
                if 0 <= posicao < len(areas_soja):
                    nova_area = calcular_area("Soja")
                    novo_insumo = calcular_insumos("Soja", nova_area)
                    areas_soja[posicao] = nova_area
                    insumos_soja[posicao] = novo_insumo
                    print("\nDados atualizados para Soja.")
                else:
                    print("Posição inválida.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número válido.")
        elif cultura == "Cacau" and len(areas_cacau) > 0:
            print("\nEntradas de Cacau:")
            for i, (area_cacau, insumo_cacau) in enumerate(zip(areas_cacau, insumos_cacau), start=1):
                print(f"{i}. Área: {area_cacau} m², KCl: {insumo_cacau} kg")
            try:
                posicao = int(input("Escolha a posição para atualizar: ")) - 1
                if 0 <= posicao < len(areas_cacau):
                    nova_area = calcular_area("Cacau")
                    novo_insumo = calcular_insumos("Cacau", nova_area)
                    areas_cacau[posicao] = nova_area
                    insumos_cacau[posicao] = novo_insumo
                    print("\nDados atualizados para Cacau.")
                else:
                    print("Posição inválida.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número válido.")
        else:
            print("Cultura ou posição não encontrada.")

    elif opcao == 5:  # Exportar dados para CSV
        exportar_dados_csv()

    elif opcao == 6:  # Sair
        print("Saindo do programa...")
        break

    else:
        print("Opção inválida. Por favor, escolha uma opção do menu.")
