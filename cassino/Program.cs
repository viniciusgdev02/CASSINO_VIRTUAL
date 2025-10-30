using System;
using System.Threading;

class Cassino
{
    //========== VARIÁVEIS GLOBAIS DO CASSINO ==========
    string nomeJogador;
    int dinheiroTotal = 0;
    int vitoriasTotais = 0;
    int derrotasTotais = 0;
    // ========== VARIÁVEIS ESPECÍFICAS DO BLACKJACK ==========
    int[] baralhoValor = new int[52];
    int[] baralhoNaipe = new int[52];
    int proximaCarta = 0;
    string[] naipes = { "♠️", "♥️", "♦️", "♣️" };
    int vitoriasBlack = 0;
    int derrotasBlack = 0;

    // ========== VARIÁVEIS ESPECÍFICAS DA CORRIDA DE CAVALOS ==========
    // CORREÇÃO: Array de strings formatado corretamente
    string[] nomesCavalos = { "🐎 JAILTON                    ",
                              "🐎 VAGABUNDO DAS ESTRELAS     ",
                              "🐎 PÉ DE PANO                 ",
                              "🐎 CASEMIRO                   ",
                              "🐎 PANGARÉ                    " };
    int[] posicoes = { 0, 0, 0, 0, 0 };
    int[] odds_cavalos = { 3, 4, 2, 5, 3 };
    int meta = 50;
    bool corrida_ativa = false;
    int vitoriasHipica = 0;
    int derrotasHipica = 0;
    int aposta_cavalos_global = 0;
    int cavalo_apostado_global = 0;

    // ========== VARIÁVEIS ESPECÍFICAS DO FUTEBOL ==========
    // Nota: O C# usa 'timesFutebol' [123] onde o Portugol usa 'times' [328]
    string[] timesFutebol = { "🦩 FLAMENGO", "👴 SÃO PAULO", "🐓 ATLETICO MG", "🐷 PALMEIRAS", "🐟 SANTOS", "🏳️‍🌈 CRUZEIRO" };
    int[] odds_futebol = { 25, 32, 28 }; // [Casa x 10, empate x 10, Visitante x 10] para simular decimais 
    int placar_casa = 0;
    int placar_visitante = 0;
    int minuto_jogo = 0;
    bool jogo_ativo = false;
    int vitoriasF = 0;
    int derrotasF = 0;
    int aposta_futebol_global = 0;
    int resultado_apostado_global = 0; // 1 = casa, 2 = empate, 3 = visitante
    int time_casa_global = 0;
    int time_visitante_global = 0;
    Random random = new Random();

    //========== FUNÇÃO PRINCIPAL ==========
    static void Main(string[] args)
    {
        Cassino cassino = new Cassino();
        cassino.mostrar_abertura();
        Console.Write("👤 DIGITE SEU NOME: ");
        cassino.nomeJogador = Console.ReadLine();
        Console.Clear();
        Console.WriteLine($"\n🎰 BEM-VINDO AO CASSINO, {cassino.nomeJogador.ToUpper()}! 🎰\n");
        cassino.menu_principal();
    }

    // ========== FUNÇÃO QUE MOSTRA A TELA DE ABERTURA ==========
    void mostrar_abertura()
    {
        Console.WriteLine("╔══════════════════════════════════════════════════════════╗");
        Console.WriteLine("║                 🎰 CASSINO VAGABUNDO 🎰                  ║");
        Console.WriteLine("║                                                          ║");
        Console.WriteLine("║                     TESTE SUA SORTE                      ║");
        Console.WriteLine("║                                                          ║");
        Console.WriteLine("║              ★ O MELHOR CASSINO VIRTUAL ★                ║");
        Console.WriteLine("╚══════════════════════════════════════════════════════════╝\n");
    }

    // ========== FUNÇÃO DO MENU PRINCIPAL ==========
    void menu_principal()
    {
        int opcao = 0;
        while (true)
        {
            Console.WriteLine($"\n{repetir_char('=', 60)}");
            Console.WriteLine("🎰               CASSINO VAGABUNDO - MENU PRINCIPAL     🎰");
            Console.WriteLine($"👤 JOGADOR: {nomeJogador} | 💰 SALDO: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
            Console.WriteLine(repetir_char('=', 60));

            Console.WriteLine("🏪 1 - COMPRAR FICHAS");
            Console.WriteLine("🃏 2 - BLACKJACK (21)");
            Console.WriteLine("🏇 3 - CORRIDA DE CAVALOS");
            Console.WriteLine("⚽ 4 - BRASFUT");
            Console.WriteLine("💰 5 - VER SALDO E ESTATÍSTICAS");
            Console.WriteLine("🚪 0 - CORRER DO VAGABUNDO");
            Console.WriteLine(repetir_char('=', 60));
            Console.Write("🎲 ESCOLHA SUA OPÇÃO: ");

            // Tratamento básico de erro para entrada não numérica
            try
            {
                opcao = Convert.ToInt32(Console.ReadLine());
            }
            catch (FormatException)
            {
                opcao = -1; // Define uma opção inválida para acionar o 'default'
            }

            Console.Clear();

            switch (opcao)
            {
                case 1:
                    comprar_fichas();
                    break;
                case 2:
                    iniciar_blackjack();
                    break;
                case 3:
                    iniciar_corrida_cavalos();
                    break;
                case 4:
                    iniciar_futebol();
                    break;
                case 5:
                    mostrar_estatisticas();
                    break;
                case 0:
                    finalizar_cassino();
                    return;
                default:
                    Console.WriteLine("❌ OPÇÃO INVÁLIDA! TENTE NOVAMENTE.");
                    break;
            }

            Console.WriteLine("\n⏸️ PRESSIONE ENTER PARA VOLTAR AO MENU PRINCIPAL...");
            Console.ReadKey();
            Console.Clear();
        }
    }

    // ========== FUNÇÃO PARA COMPRAR FICHAS ==========
    void comprar_fichas()
    {
        int fichas = 0;
        Console.WriteLine("\n💳 === COMPRA DE FICHAS === 💳");
        Console.WriteLine("🎫 PREÇO: R$ 10 POR FICHA");
        Console.WriteLine($"💰 SALDO ATUAL: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
        Console.Write("🛒 QUANTAS FICHAS DESEJA COMPRAR? ");

        // Tratamento de erro para entrada
        bool entradaValida = false;
        while (!entradaValida)
        {
            try
            {
                fichas = Convert.ToInt32(Console.ReadLine());
                if (fichas <= 0)
                {
                    Console.Write("❌ NÚMERO INVÁLIDO! DIGITE PELO MENOS 1 FICHA: ");
                }
                else
                {
                    entradaValida = true;
                }
            }
            catch (FormatException)
            {
                Console.Write("❌ ENTRADA INVÁLIDA! DIGITE UM NÚMERO: ");
            }
        }

        dinheiroTotal += (fichas * 10);
        Console.WriteLine($"✅ VOCÊ COMPROU {fichas} FICHAS POR R$ {fichas * 10}");
        Console.WriteLine($"💰 NOVO SALDO: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
    }

    // ========== FUNÇÃO QUE MOSTRA AS ESTATÍSTICAS DETALHADAS ==========
    void mostrar_estatisticas()
    {
        Console.WriteLine("\n📊 === ESTATÍSTICAS DO CASSINO === 📊");
        Console.WriteLine($"👤 JOGADOR: {nomeJogador}");
        Console.WriteLine($"💰 SALDO TOTAL: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)\n");

        Console.WriteLine("🃏 BLACKJACK:");
        Console.WriteLine($"   🏆 VITÓRIAS: {vitoriasBlack}");
        Console.WriteLine($"   💀 DERROTAS: {derrotasBlack}\n");

        Console.WriteLine("🏇 CORRIDA DE CAVALOS:");
        Console.WriteLine($"   🏆 VITÓRIAS: {vitoriasHipica}");
        Console.WriteLine($"   💀 DERROTAS: {derrotasHipica}\n");

        Console.WriteLine("⚽ BRASFUT:");
        Console.WriteLine($"   🏆 VITÓRIAS: {vitoriasF}");
        Console.WriteLine($"   💀 DERROTAS: {derrotasF}\n");
        int totalJogos = vitoriasBlack + derrotasBlack + vitoriasHipica + derrotasHipica + vitoriasF + derrotasF;
        int totalVitorias = vitoriasBlack + vitoriasHipica + vitoriasF;

        if (totalJogos > 0)
        {
            Console.WriteLine("📈 RESUMO GERAL:");
            Console.WriteLine($"   🎮 TOTAL DE JOGOS: {totalJogos}");
            Console.WriteLine($"   🏆 TOTAL DE VITÓRIAS: {totalVitorias}");
            Console.WriteLine($"   💀 TOTAL DE DERROTAS: {totalJogos - totalVitorias}");
            // Evita divisão por zero se totalJogos for 0
            Console.WriteLine($"   📊 TAXA DE VITÓRIA: {(double)totalVitorias * 100 / totalJogos:F0}%");
        }

        if (dinheiroTotal >= 12000)
        {
            Console.WriteLine("\n🎉🎉🎉 PARABÉNS!!! 🎉🎉🎉");
            Console.WriteLine("É HORA DE COMPRAR SUA PLACA DE VÍDEO!");
        }
    }

    // ========== FUNÇÃO QUE ENCERRA O CASSINO ==========
    void finalizar_cassino()
    {
        Console.WriteLine("\n🎰 === OBRIGADO POR JOGAR NO CASSINO VAGABUNDO === 🎰");
        Console.WriteLine($"👤 JOGADOR: {nomeJogador}");
        Console.WriteLine($"💰 SALDO FINAL: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
        Console.WriteLine($"🏆 VITÓRIAS TOTAIS: {vitoriasBlack + vitoriasHipica + vitoriasF}");
        Console.WriteLine($"💀 DERROTAS TOTAIS: {derrotasBlack + derrotasHipica + derrotasF}");
        Console.WriteLine("\n🎲 VOLTE SEMPRE! A SORTE PODE MUDAR! 🍀");
    }

    // ========== MÉTODO AUXILIAR (PORTADO DO PORTUGOL) ==========
    string repetir_char(char c, int count)
    {
        return new string(c, count);
    }


    // =========================================================================
    // ========================= SEÇÃO BLACKJACK ===============================
    // =========================================================================

    void iniciar_blackjack()
    {
        Console.WriteLine("\n💀💀💀  BLACKJACK  💀💀💀\n");
        if (dinheiroTotal <= 0)
        {
            Console.WriteLine("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!");
            return;
        }

        int fichasApostadas = 0;
        Console.WriteLine($"💵 SALDO ATUAL: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
        Console.Write("🎲 QUANTAS FICHAS DESEJA APOSTAR? ");

        // Tratamento de erro para aposta
        bool apostaValida = false;
        while (!apostaValida)
        {
            try
            {
                fichasApostadas = Convert.ToInt32(Console.ReadLine());
                if (fichasApostadas <= 0 || fichasApostadas > (dinheiroTotal / 10))
                {
                    Console.Write($"⚠️ APOSTA INVÁLIDA. DIGITE UM NÚMERO DE FICHAS ENTRE 1 E {dinheiroTotal / 10}: ");
                }
                else
                {
                    apostaValida = true;
                }
            }
            catch (FormatException)
            {
                Console.Write($"❌ ENTRADA INVÁLIDA! DIGITE UM NÚMERO ENTRE 1 E {dinheiroTotal / 10}: ");
            }
        }

        Console.Clear();
        int aposta = fichasApostadas * 10;
        rodada_blackjack(aposta);
    }

    void rodada_blackjack(int aposta)
    {
        proximaCarta = 0;
        preencheBaralho();
        embaralhaBaralho();

        int somaJogador = jogarJogador();
        int somaDealer = 0;
        // Dealer só joga se o jogador não tiver estourado
        if (somaJogador <= 21)
        {
            somaDealer = jogarDealerInteligente(somaJogador);
        }
        else
        {
            Console.WriteLine("\n⏳ VEZ DO DEALER ⏳");
            Console.WriteLine("DEALER NÃO PRECISA JOGAR, VOCÊ JÁ ESTOUROU.");
        }

        mostrarResultadoBlack(somaJogador, somaDealer, aposta);
    }

    int jogarJogador()
    {
        int soma = 0;
        int i = 1;
        bool ativo = true;
        while (ativo)
        {
            int valor = baralhoValor[proximaCarta];
            int naipe = baralhoNaipe[proximaCarta];
            proximaCarta++;

            Console.WriteLine($"SUA {i}° CARTA: {mostrarCarta(valor, naipe)}");
            soma += valorCartaJogador(valor, soma);
            Console.WriteLine($"TOTAL ATUAL: {soma}\n");
            if (soma >= 21)
            {
                if (soma > 21)
                    Console.WriteLine("🏢🏢💥🛩 VOCÊ ESTOUROU! PASSOU DE 21.");
                else
                    Console.WriteLine("👏🏼 PARABÉNS! VOCÊ FEZ 21!");
                ativo = false;
                break;
            }

            // Loop para garantir S ou N
            bool entradaOpcaoValida = false;
            while (!entradaOpcaoValida)
            {
                Console.Write("DESEJA PEDIR MAIS UMA CARTA? (S/N): ");
                string input = Console.ReadLine().ToUpper();
                if (input.Length > 0)
                {
                    char opcao = input[0];
                    if (opcao == 'S' || opcao == 'N')
                    {
                        entradaOpcaoValida = true;
                        if (opcao == 'N')
                            ativo = false;
                    }
                    else
                    {
                        Console.WriteLine("❌ Digite apenas 'S' (Sim) ou 'N' (Não).");
                    }
                }
            }
            
            Console.Clear();
            i++;
        }

        return soma;
    }

    // ========== DEALER INTELIGENTE (PORTADO DO PORTUGOL) ==========
    int jogarDealerInteligente(int somaJogador)
    {
        Console.WriteLine("\n⏳ VEZ DO DEALER ⏳\n");
        int soma = 0;
        int i = 1;

        // Primeira rodada: dealer sempre pega cartas até 17 (regra padrão)
        while (soma < 17)
        {
            Thread.Sleep(1500);
            int valor = baralhoValor[proximaCarta];
            int naipe = baralhoNaipe[proximaCarta];
            proximaCarta++;

            Console.WriteLine($"{i}° CARTA DO DEALER: {mostrarCarta(valor, naipe)}");
            soma += valorCartaDealer(valor, soma);
            Console.WriteLine($"TOTAL DO DEALER: {soma}\n");

            if (soma > 21)
            {
                Console.WriteLine("DEALER ESTOUROU! PASSOU DE 21.");
                return soma;
            }

            i++;
        }

        // ========== INTELIGÊNCIA DO DEALER ==========
        // Se o jogador não estourou, dealer analisa se deve arriscar mais
        if (somaJogador <= 21 && soma < somaJogador && soma >= 17)
        {
            Console.WriteLine("🤖 DEALER ANALISANDO A SITUAÇÃO...");
            Thread.Sleep(1500);

            // Lógica de decisão do dealer inteligente
            bool deveArriscar = false;
            if (somaJogador == 21)
            {
                if (soma < 21)
                {
                    Console.WriteLine("💭 'O jogador tem 21... preciso arriscar!'");
                    deveArriscar = true;
                }
            }
            else if (somaJogador >= 19 && soma < somaJogador)
            {
                // Se jogador tem 19-20, dealer arrisca com 80% de chance
                int chance = random.Next(1, 101);
                if (chance <= 80)
                {
                    Console.WriteLine($"💭 'Jogador está com {somaJogador}... vou arriscar!'");
                    deveArriscar = true;
                }
                else
                {
                    Console.WriteLine($"💭 'Muito arriscado... vou ficar com {soma}'");
                }
            }
            else if (somaJogador >= 18 && soma < somaJogador)
            {
                // Se jogador tem 18, dealer arrisca com 60% de chance
                int chance = random.Next(1, 101);
                if (chance <= 60)
                {
                    Console.WriteLine("💭 'Posso tentar uma carta...'");
                    deveArriscar = true;
                }
                else
                {
                    Console.WriteLine("💭 'Melhor não arriscar demais'");
                }
            }
            else if (soma < somaJogador)
            {
                // Para outros casos, dealer arrisca com 40% de chance
                int chance = random.Next(1, 101);
                if (chance <= 40)
                {
                    Console.WriteLine("💭 'Vou tentar mais uma...'");
                    deveArriscar = true;
                }
            }

            // Se decidir arriscar, pega mais cartas com estratégia
            if (deveArriscar)
            {
                while (soma < somaJogador && soma < 21)
                {
                    Thread.Sleep(1800);
                    int valor = baralhoValor[proximaCarta];
                    int naipe = baralhoNaipe[proximaCarta];
                    proximaCarta++;

                    Console.WriteLine($"{i}° CARTA DO DEALER (ARRISCANDO): {mostrarCarta(valor, naipe)}");
                    soma += valorCartaDealer(valor, soma);
                    Console.WriteLine($"TOTAL DO DEALER: {soma}\n");

                    if (soma > 21)
                    {
                        Console.WriteLine("💥 DEALER ARRISCOU E ESTOUROU!");
                        break;
                    }
                    else if (soma >= somaJogador)
                    {
                        Console.WriteLine("😎 DEALER CONSEGUIU TE ALCANÇAR!");
                        break;
                    }
                    else
                    {
                        int limite_seguro = 21 - soma;
                        if (limite_seguro <= 4) // Se só pode receber até 4, chance alta de estourar
                        {
                            int chance_parar = random.Next(1, 101);
                            if (chance_parar <= 70) // 70% chance de parar quando arriscado
                            {
                                Console.WriteLine("💭 'Muito perigoso continuar... vou parar aqui'");
                                break;
                            }
                        }
                    }
                    i++;
                }
            }
        }

        Thread.Sleep(2000);
        return soma;
    }

    void mostrarResultadoBlack(int somaJogador, int somaDealer, int aposta)
    {
        Console.WriteLine("\n📊 RESULTADO FINAL 📊");
        Console.WriteLine($"SEUS PONTOS: {somaJogador}");
        Console.WriteLine($"PONTOS DO DEALER: {somaDealer}");
        Thread.Sleep(2000);

        if (somaJogador > 21 && somaDealer > 21)
        {
            Console.WriteLine("\n🤝 EMPATE! AMBOS ESTOURARAM.");
        }
        else if (somaJogador > 21)
        {
            Console.WriteLine("\n💥 VOCÊ PERDEU! ESTOUROU.");
            dinheiroTotal -= aposta;
            derrotasBlack++;
        }
        else if (somaDealer > 21)
        {
            Console.WriteLine("\n🏆 VOCÊ VENCEU! O DEALER ESTOUROU.");
            dinheiroTotal += aposta;
            vitoriasBlack++;
        }
        else if (somaJogador > somaDealer)
        {
            Console.WriteLine("\n🏆 VOCÊ VENCEU! TEM MAIS PONTOS.");
            dinheiroTotal += aposta;
            vitoriasBlack++;
        }
        else if (somaJogador < somaDealer)
        {
            Console.WriteLine("\n💀 VOCÊ PERDEU! O DEALER TEM MAIS PONTOS.");
            dinheiroTotal -= aposta;
            derrotasBlack++;
        }
        else // (somaJogador == somaDealer)
        {
            Console.WriteLine("\n🤝 EMPATE! MESMA PONTUAÇÃO.");
        }

        Console.WriteLine($"\n💰 SALDO ATUAL: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
    }

    // ========== MÉTODOS AUXILIARES DO BLACKJACK (PORTADOS DO PORTUGOL) ==========

    void preencheBaralho()
    {
        int i = 0;
        // 4 Naipes
        for (int naipe = 0; naipe < 4; naipe++)
        {
            // 13 Valores (1=Ás, 11=J, 12=Q, 13=K)
            for (int valor = 1; valor <= 13; valor++)
            {
                baralhoValor[i] = valor;
                baralhoNaipe[i] = naipe;
                i++;
            }
        }
    }

    void embaralhaBaralho()
    {
        // Algoritmo Fisher-Yates
        for (int i = 51; i > 0; i--)
        {
            int j = random.Next(0, i + 1);

            // Troca valor
            int tempValor = baralhoValor[i];
            baralhoValor[i] = baralhoValor[j];
            baralhoValor[j] = tempValor;

            // Troca naipe
            int tempNaipe = baralhoNaipe[i];
            baralhoNaipe[i] = baralhoNaipe[j];
            baralhoNaipe[j] = tempNaipe;
        }
        proximaCarta = 0; // Reinicia o topo do baralho
    }

    string mostrarCarta(int valor, int naipeIdx)
    {
        string valorStr;
        switch (valor)
        {
            case 1:
                valorStr = "A"; // Ás
                break;
            case 11:
                valorStr = "J"; // Valete
                break;
            case 12:
                valorStr = "Q"; // Dama
                break;
            case 13:
                valorStr = "K"; // Rei
                break;
            default:
                valorStr = valor.ToString();
                break;
        }
        // Usa o array global 'naipes'
        return $"{valorStr}{naipes[naipeIdx]}";
    }

    int valorCartaJogador(int valor, int somaAtual)
    {
        if (valor >= 10) return 10; // J, Q, K
        if (valor == 1) // Ás
        {
            // Se 11 não estourar, vale 11. Senão, vale 1.
            if (somaAtual + 11 > 21) return 1;
            else return 11;
        }
        return valor; // Cartas 2-9
    }

    int valorCartaDealer(int valor, int somaAtual)
    {
        if (valor >= 10) return 10; // J, Q, K
        if (valor == 1) // Ás
        {
            // Dealer (IA) usa Ás como 11 se não estourar
            if (somaAtual + 11 <= 21) return 11;
            else return 1;
        }
        return valor;
    }


    // =========================================================================
    // ========================= SEÇÃO CORRIDA DE CAVALOS ======================
    // =========================================================================

    void iniciar_corrida_cavalos()
    {
        Console.WriteLine("\n🏇 === BEM-VINDO AO HIPÓDROMO === 🏇");
        if (dinheiroTotal <= 0)
        {
            Console.WriteLine("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!");
            return;
        }

        menu_hipica();
        Console.Clear();
    }

    void menu_hipica()
    {
        int opcao = -1;
        while (true)
        {
            Console.WriteLine($"\n{repetir_char('=', 50)}");
            Console.WriteLine("🏇 HIPÓDROMO VAGABUNDO 🏇");
            Console.WriteLine($"💰 SALDO: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
            if (aposta_cavalos_global > 0)
            {
                if (cavalo_apostado_global >= 1 && cavalo_apostado_global <= nomesCavalos.Length)
                {
                    Console.WriteLine($"🎯 APOSTA ATUAL: {nomesCavalos[cavalo_apostado_global - 1]} - R$ {aposta_cavalos_global}");
                }
            }

            Console.WriteLine(repetir_char('=', 50));
            Console.WriteLine("1. 📋 VER CAVALOS E ODDS");
            Console.WriteLine("2. 💸 FAZER APOSTA");
            Console.WriteLine("3. 🏁 INICIAR CORRIDA");
            Console.WriteLine("0. 🔙 VOLTAR AO MENU PRINCIPAL");
            Console.WriteLine(repetir_char('=', 50));
            Console.Write("ESCOLHA UMA OPÇÃO: ");

            try
            {
                opcao = Convert.ToInt32(Console.ReadLine());
            }
            catch (FormatException)
            {
                opcao = -1;
            }

            Console.Clear();

            switch (opcao)
            {
                case 1:
                    mostrar_cavalos();
                    break;
                case 2:
                    if (!corrida_ativa)
                    {
                        fazer_aposta_cavalos();
                    }
                    else
                    {
                        Console.WriteLine("❌ NÃO É POSSÍVEL APOSTAR DURANTE A CORRIDA!");
                    }
                    break;
                case 3:
                    if (aposta_cavalos_global > 0)
                    {
                        iniciar_corrida_completa(aposta_cavalos_global, cavalo_apostado_global);
                        aposta_cavalos_global = 0;
                        cavalo_apostado_global = 0;
                    }
                    else
                    {
                        Console.WriteLine("❌ VOCÊ PRECISA FAZER UMA APOSTA PRIMEIRO!");
                    }
                    break;
                case 0:
                    if (aposta_cavalos_global > 0)
                    {
                        Console.WriteLine($"APOSTA DE R$ {aposta_cavalos_global} CANCELADA E DEVOLVIDA.");
                        dinheiroTotal += aposta_cavalos_global;
                        aposta_cavalos_global = 0;
                        cavalo_apostado_global = 0;
                    }
                    return;
                default:
                    Console.WriteLine("❌ OPÇÃO INVÁLIDA!");
                    break;
            }

            Console.WriteLine("\nPRESSIONE ENTER PARA CONTINUAR...");
            Console.ReadKey();
            Console.Clear();
        }
    }

    void mostrar_cavalos()
    {
        Console.WriteLine("\n🏇 === CAVALOS PARTICIPANTES === 🏇");
        for (int i = 0; i < 5; i++)
        {
            Console.Write($"CAVALO {i + 1}: {nomesCavalos[i]}");
            Console.Write($" | ODD: {odds_cavalos[i]}X");

            if (odds_cavalos[i] == 2)
                Console.Write(" (FAVORITO)");
            else if (odds_cavalos[i] >= 4)
                Console.Write(" (AZARÃO)");
            Console.WriteLine();
        }
    }

    void fazer_aposta_cavalos()
    {
        if (aposta_cavalos_global > 0)
        {
            Console.WriteLine("CANCELANDO APOSTA ANTERIOR...");
            dinheiroTotal += aposta_cavalos_global;
            aposta_cavalos_global = 0;
            cavalo_apostado_global = 0;
        }

        mostrar_cavalos();
        Console.WriteLine($"\n💰 SEU SALDO: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");

        int cavalo_apostado = 0;
        while (cavalo_apostado < 1 || cavalo_apostado > 5)
        {
            Console.Write("EM QUAL CAVALO DESEJA APOSTAR (1-5)? ");
            try { cavalo_apostado = Convert.ToInt32(Console.ReadLine()); } catch (FormatException) { }
            if (cavalo_apostado < 1 || cavalo_apostado > 5)
            {
                Console.WriteLine("❌ CAVALO INVÁLIDO!");
            }
        }

        int fichas_apostadas = 0;
        while (fichas_apostadas <= 0 || fichas_apostadas > (dinheiroTotal / 10))
        {
            Console.Write("QUANTAS FICHAS DESEJA APOSTAR? ");
            try { fichas_apostadas = Convert.ToInt32(Console.ReadLine()); } catch (FormatException) { }
            if (fichas_apostadas <= 0 || fichas_apostadas > (dinheiroTotal / 10))
            {
                Console.WriteLine($"❌ VALOR DE APOSTA INVÁLIDO! (Mín: 1, Máx: {dinheiroTotal / 10})");
            }
        }

        Console.Clear();

        int aposta = fichas_apostadas * 10;
        dinheiroTotal -= aposta;

        Console.WriteLine("\n✅ APOSTA CONFIRMADA!");
        Console.WriteLine($"🏇 CAVALO: {nomesCavalos[cavalo_apostado - 1]}");
        Console.WriteLine($"💰 VALOR: R$ {aposta} ({fichas_apostadas} FICHAS)");
        Console.WriteLine($"🎯 RETORNO POTENCIAL: R$ {aposta * odds_cavalos[cavalo_apostado - 1]}");
        Console.WriteLine($"💳 SALDO RESTANTE: R$ {dinheiroTotal}");

        aposta_cavalos_global = aposta;
        cavalo_apostado_global = cavalo_apostado;
    }

    void iniciar_corrida_completa(int aposta, int cavalo_apostado)
    {
        corrida_ativa = true;
        for (int i = 0; i < 5; i++)
        {
            posicoes[i] = 0;
        }

        Console.WriteLine("\n🏁 === INICIANDO A CORRIDA === 🏁");
        Console.WriteLine($"🔥 SUA APOSTA: {nomesCavalos[cavalo_apostado - 1]} - R$ {aposta}\n");

        for (int i = 3; i >= 1; i--)
        {
            Console.Write($"{i}... ");
            Thread.Sleep(1000);
        }
        Console.WriteLine("🏁 LARGADA!\n");
        Thread.Sleep(1000);

        int vencedor = 0;
        while (vencedor == 0)
        {
            for (int i = 0; i < 5; i++)
            {
                // Lógica do Portugol: ODD menor (favorito) tem mais chance de avançar mais
                int avancoMaximo = 7 - odds_cavalos[i];
                if (avancoMaximo <= 1) avancoMaximo = 2; // Garante avanço mínimo
                
                int avanco = random.Next(1, avancoMaximo + 1); // +1 pois o Next é exclusivo
                posicoes[i] += avanco;

                if (posicoes[i] >= meta && vencedor == 0)
                {
                    vencedor = i + 1;
                }
            }
            Console.Clear();
            mostrar_pista();

            Thread.Sleep(500); // Mais rápido que no Portugol
        }

        processar_resultado_cavalos(vencedor, aposta, cavalo_apostado);
        corrida_ativa = false;
    }

    void mostrar_pista()
    {
        Console.WriteLine("\n📍 POSIÇÕES:");
        for (int i = 0; i < 5; i++)
        {
            Console.Write($"{nomesCavalos[i]}: ");
            int pos_visual = (posicoes[i] * 30) / meta; // Mapeia a posição para 30 caracteres

            if (pos_visual > 29)
            {
                pos_visual = 29;
            }

            if (posicoes[i] >= meta)
            {
                Console.Write(repetir_char('-', 29) + "🏆");
            }
            else
            {
                for (int j = 0; j < 30; j++)
                {
                    if (j == pos_visual)
                    {
                        Console.Write("🏇");
                    }
                    else if (j == 29)
                    {
                        Console.Write("🏁");
                    }
                    else
                    {
                        Console.Write("-");
                    }
                }
            }
            Console.WriteLine();
        }
    }

    void processar_resultado_cavalos(int vencedor, int aposta, int cavalo_apostado)
    {
        Console.WriteLine($"\n{repetir_char('=', 50)}");
        Console.WriteLine("🏆 RESULTADO FINAL 🏆");
        Console.WriteLine(repetir_char('=', 50));
        Console.WriteLine($"🥇 VENCEDOR: {nomesCavalos[vencedor - 1]}");
        if (vencedor == cavalo_apostado)
        {
            int premio = aposta * odds_cavalos[cavalo_apostado - 1];
            dinheiroTotal += premio;
            vitoriasHipica++;

            Console.WriteLine("\n🎉 PARABÉNS! VOCÊ GANHOU! 🎉");
            Console.WriteLine($"💰 PRÊMIO: R$ {premio}");
            Console.WriteLine($"💳 NOVO SALDO: R$ {dinheiroTotal}");
        }
        else
        {
            derrotasHipica++;
            Console.WriteLine("\n😔 QUE PENA! VOCÊ PERDEU DESTA VEZ.");
            Console.WriteLine($"🏇 VOCÊ APOSTOU EM: {nomesCavalos[cavalo_apostado - 1]}");
            Console.WriteLine($"💸 VALOR PERDIDO: R$ {aposta}");
            Console.WriteLine($"💳 SALDO ATUAL: R$ {dinheiroTotal}");
        }
    }

    // =========================================================================
    // ===================== SEÇÃO APOSTAS DE FUTEBOL (PORTADO) ================
    // =========================================================================

    void iniciar_futebol()
    {
        Console.WriteLine("\n⚽ === BEM-VINDO ÀS APOSTAS DE FUTEBOL === ⚽");
        if (dinheiroTotal <= 0)
        {
            Console.WriteLine("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!");
            return;
        }

        menu_futebol();
        Console.Clear(); // Limpa a tela ao sair do menu de futebol
    }

    void menu_futebol()
    {
        // Devolve dinheiro se aposta foi feita mas não simulada
        if (aposta_futebol_global > 0)
        {
            Console.WriteLine($"APOSTA ANTERIOR DE R$ {aposta_futebol_global} CANCELADA E DEVOLVIDA.");
            dinheiroTotal += aposta_futebol_global;
        }

        // Seleciona aleatoriamente os times
        time_casa_global = random.Next(0, timesFutebol.Length);
        time_visitante_global = random.Next(0, timesFutebol.Length);

        // Garante que não sejam o mesmo time
        while (time_casa_global == time_visitante_global)
        {
            time_visitante_global = random.Next(0, timesFutebol.Length);
        }

        // Reinicia o jogo
        jogo_ativo = false;
        aposta_futebol_global = 0;
        resultado_apostado_global = 0;

        int opcao = -1;
        while (true)
        {
            Console.WriteLine($"\n{repetir_char('=', 60)}");
            Console.WriteLine("⚽ BRASFUT - APOSTAS ⚽");
            Console.WriteLine($"💰 SALDO: R$ {dinheiroTotal} ({dinheiroTotal / 10} FICHAS)");
            Console.WriteLine(repetir_char('=', 60));
            Console.WriteLine("PARTIDA ATUAL:");
            // Usa divisão por 10.0 para forçar o resultado decimal (ex: 2.5)
            Console.WriteLine($"  CASA: {timesFutebol[time_casa_global]} (ODD: {odds_futebol[0] / 10.0}x)");
            Console.WriteLine($"  EMPATE: (ODD: {odds_futebol[1] / 10.0}x)");
            Console.WriteLine($"  VISITANTE: {timesFutebol[time_visitante_global]} (ODD: {odds_futebol[2] / 10.0}x)");

            if (aposta_futebol_global > 0)
            {
                string apostaFeita = "";
                if (resultado_apostado_global == 1) apostaFeita = timesFutebol[time_casa_global];
                else if (resultado_apostado_global == 2) apostaFeita = "EMPATE";
                else apostaFeita = timesFutebol[time_visitante_global];

                Console.WriteLine($"\n🎯 APOSTA ATUAL: {apostaFeita} - R$ {aposta_futebol_global}");
            }

            Console.WriteLine(repetir_char('=', 60));
            Console.WriteLine("1. 💸 FAZER APOSTA");
            Console.WriteLine("2. 🏟️ SIMULAR PARTIDA");
            Console.WriteLine("3. 🔄 VER NOVA PARTIDA");
            Console.WriteLine("0. 🔙 VOLTAR AO MENU PRINCIPAL");
            Console.WriteLine(repetir_char('=', 60));
            Console.Write("ESCOLHA UMA OPÇÃO: ");

            try { opcao = Convert.ToInt32(Console.ReadLine()); } catch (FormatException) { opcao = -1; }

            Console.Clear();

            switch (opcao)
            {
                case 1:
                    if (!jogo_ativo)
                    {
                        fazer_aposta_futebol();
                    }
                    else
                    {
                        Console.WriteLine("❌ O JOGO JÁ FOI SIMULADO! VEJA UMA NOVA PARTIDA (OPÇÃO 3).");
                    }
                    break;
                case 2:
                    if (aposta_futebol_global > 0)
                    {
                        if (!jogo_ativo)
                        {
                            simular_partida_futebol();
                        }
                        else
                        {
                            Console.WriteLine("❌ O JOGO JÁ FOI SIMULADO! VEJA UMA NOVA PARTIDA (OPÇÃO 3).");
                        }
                    }
                    else
                    {
                        Console.WriteLine("❌ VOCÊ PRECISA FAZER UMA APOSTA PRIMEIRO (OPÇÃO 1).");
                    }
                    break;
                case 3:
                    // Devolve dinheiro se aposta foi feita mas não simulada
                    if (aposta_futebol_global > 0 && !jogo_ativo)
                    {
                        Console.WriteLine($"APOSTA DE R$ {aposta_futebol_global} CANCELADA E DEVOLVIDA.");
                        dinheiroTotal += aposta_futebol_global;
                    }

                    // Reseta tudo para a próxima partida
                    time_casa_global = random.Next(0, timesFutebol.Length);
                    time_visitante_global = random.Next(0, timesFutebol.Length);
                    while (time_casa_global == time_visitante_global)
                    {
                        time_visitante_global = random.Next(0, timesFutebol.Length);
                    }
                    jogo_ativo = false;
                    aposta_futebol_global = 0;
                    resultado_apostado_global = 0;

                    Console.WriteLine("🔄 GERANDO NOVA PARTIDA...");
                    break;
                case 0:
                    // Devolve dinheiro se aposta foi feita mas não simulada
                    if (aposta_futebol_global > 0 && !jogo_ativo)
                    {
                        Console.WriteLine($"APOSTA DE R$ {aposta_futebol_global} CANCELADA E DEVOLVIDA.");
                        dinheiroTotal += aposta_futebol_global;
                    }
                    return; // Sai do menu_futebol
                default:
                    Console.WriteLine("❌ OPÇÃO INVÁLIDA!");
                    break;
            }

            if (opcao != 0)
            {
                Console.WriteLine("\nPRESSIONE ENTER PARA CONTINUAR...");
                Console.ReadKey();
                Console.Clear();
            }
        }
    }

    void fazer_aposta_futebol()
    {
        // Cancela aposta anterior
        if (aposta_futebol_global > 0)
        {
            Console.WriteLine("CANCELANDO APOSTA ANTERIOR...");
            dinheiroTotal += aposta_futebol_global;
            aposta_futebol_global = 0;
            resultado_apostado_global = 0;
        }

        Console.WriteLine("\n💸 === FAZER APOSTA ===");
        Console.WriteLine($"1. {timesFutebol[time_casa_global]} (Odd: {odds_futebol[0] / 10.0}x)");
        Console.WriteLine($"2. EMPATE (Odd: {odds_futebol[1] / 10.0}x)");
        Console.WriteLine($"3. {timesFutebol[time_visitante_global]} (Odd: {odds_futebol[2] / 10.0}x)");

        int resultado_aposta = 0;
        while (resultado_aposta < 1 || resultado_aposta > 3)
        {
            Console.Write("EM QUAL RESULTADO DESEJA APOSTAR (1-3)? ");
            try { resultado_aposta = Convert.ToInt32(Console.ReadLine()); } catch (FormatException) { }
            if (resultado_aposta < 1 || resultado_aposta > 3)
            {
                Console.WriteLine("❌ OPÇÃO INVÁLIDA!");
            }
        }

        int fichas_apostadas = 0;
        while (fichas_apostadas <= 0 || fichas_apostadas > (dinheiroTotal / 10))
        {
            Console.Write("QUANTAS FICHAS DESEJA APOSTAR? ");
            try { fichas_apostadas = Convert.ToInt32(Console.ReadLine()); } catch (FormatException) { }
            if (fichas_apostadas <= 0 || fichas_apostadas > (dinheiroTotal / 10))
            {
                Console.WriteLine($"❌ VALOR DE APOSTA INVÁLIDO! (Mín: 1, Máx: {dinheiroTotal / 10})");
            }
        }

        Console.Clear();
        int aposta = fichas_apostadas * 10;
        dinheiroTotal -= aposta;

        aposta_futebol_global = aposta;
        resultado_apostado_global = resultado_aposta;

        Console.WriteLine("✅ APOSTA CONFIRMADA!");
        Console.WriteLine($"💰 VALOR: R$ {aposta}");
        Console.WriteLine($"💳 SALDO RESTANTE: R$ {dinheiroTotal}");
    }

    void simular_partida_futebol()
    {
        jogo_ativo = true;
        placar_casa = 0;
        placar_visitante = 0;
        minuto_jogo = 0;

        Console.WriteLine("🏟️ O JOGO COMEÇA!");
        Console.WriteLine($"CASA: {timesFutebol[time_casa_global]}");
        Console.WriteLine($"VISITANTE: {timesFutebol[time_visitante_global]}");

        while (minuto_jogo < 90)
        {
            Thread.Sleep(100); // 100ms por "rodada"
            minuto_jogo += 5; // Simula 5 minutos

            int chance_gol_casa = 30; // Chance base
            int chance_gol_visitante = 20; // Visitante tem desvantagem

            // Ajusta a chance com base nas odds (quanto menor a odd, maior a chance)
            if (odds_futebol[0] < odds_futebol[2])
                chance_gol_casa += 15;
            else if (odds_futebol[2] < odds_futebol[0])
                chance_gol_visitante += 10;
            
            // Odds de empate altas diminuem chance de gol
            if (odds_futebol[1] > 35)
            {
                chance_gol_casa -= 5;
                chance_gol_visitante -= 5;
            }

            int gol_casa = random.Next(1, 1001);
            int gol_visitante = random.Next(1, 1001);

            Console.Clear();
            Console.WriteLine("⚽ BRASFUT - AO VIVO ⚽");
            Console.WriteLine($"{repetir_char('=', 40)}");
            Console.WriteLine($"⏱️ MINUTO: {minuto_jogo}'");
            Console.WriteLine($"CASA:      {timesFutebol[time_casa_global]} {placar_casa}");
            Console.WriteLine($"VISITANTE: {timesFutebol[time_visitante_global]} {placar_visitante}");
            Console.WriteLine($"{repetir_char('=', 40)}");

            if (gol_casa <= chance_gol_casa)
            {
                placar_casa++;
                Console.WriteLine($"\n🔥 GOOOOL DA CASA! {timesFutebol[time_casa_global]} marca aos {minuto_jogo}'!");
                Thread.Sleep(1000); // Pausa para ver o gol
            }
            if (gol_visitante <= chance_gol_visitante)
            {
                placar_visitante++;
                Console.WriteLine($"\n🔥 GOOOOL DO VISITANTE! {timesFutebol[time_visitante_global]} marca aos {minuto_jogo}'!");
                Thread.Sleep(1000); // Pausa para ver o gol
            }
        }

        Console.WriteLine("\n🏁 FIM DE JOGO! 🏁");
        Thread.Sleep(2000);
        processar_resultado_futebol();
    }

    void processar_resultado_futebol()
    {
        Console.WriteLine("\n📊 === RESULTADO DA APOSTA === 📊");
        Console.WriteLine($"PLACAR FINAL: {timesFutebol[time_casa_global]} {placar_casa} x {placar_visitante} {timesFutebol[time_visitante_global]}");

        int resultado_real = 0;
        if (placar_casa > placar_visitante)
            resultado_real = 1; // Casa venceu
        else if (placar_casa == placar_visitante)
            resultado_real = 2; // Empate
        else
            resultado_real = 3; // Visitante venceu

        string apostaFeitaStr = "";
        if (resultado_apostado_global == 1) apostaFeitaStr = $"VITÓRIA {timesFutebol[time_casa_global]}";
        else if (resultado_apostado_global == 2) apostaFeitaStr = "EMPATE";
        else apostaFeitaStr = $"VITÓRIA {timesFutebol[time_visitante_global]}";

        Console.WriteLine($"Sua aposta: R$ {aposta_futebol_global} em [{apostaFeitaStr}]");

        if (resultado_real == resultado_apostado_global)
        {
            // Calcula o prêmio. Ex: aposta 100, odd 2.5 (25) -> (100 * 25) / 10 = 250
            int premio = (aposta_futebol_global * odds_futebol[resultado_apostado_global - 1]) / 10;
            dinheiroTotal += premio;
            vitoriasF++;

            Console.WriteLine("\n🎉 PARABÉNS! VOCÊ GANHOU! 🎉");
            Console.WriteLine($"💰 PRÊMIO: R$ {premio}");
            Console.WriteLine($"💳 NOVO SALDO: R$ {dinheiroTotal}");
        }
        else
        {
            derrotasF++;
            Console.WriteLine("\n😔 QUE PENA! VOCÊ PERDEU DESTA VEZ.");
            Console.WriteLine($"💸 VALOR PERDIDO: R$ {aposta_futebol_global}");
            Console.WriteLine($"💳 SALDO ATUAL: R$ {dinheiroTotal}");
        }

        // Reseta a aposta após o processamento
        aposta_futebol_global = 0;
        resultado_apostado_global = 0;
    }

} // <--- CHAVE FINAL FECHANDO A CLASSE CASSINO