programa
{
    // ========== INCLUINDO BIBLIOTECA UTIL PARA FUNÇÕES ESPECIAIS ==========
    inclua biblioteca Util --> u
    
    // ========== VARIÁVEIS GLOBAIS DO CASSINO ==========
    cadeia nomeJogador
    inteiro dinheiroTotal = 0
    inteiro vitoriasTotais = 0
    inteiro derrotasTotais = 0
    
    // ========== VARIÁVEIS ESPECÍFICAS DO BLACKJACK ==========
    inteiro baralhoValor[52]
    inteiro baralhoNaipe[52]
    inteiro proximaCarta = 0
    cadeia naipes[4] = {"♠️", "♥️", "♦️", "♣️"}
    inteiro vitoriasBlack = 0
    inteiro derrotasBlack = 0
    
    // ========== VARIÁVEIS ESPECÍFICAS DA CORRIDA DE CAVALOS ========== 
    cadeia nomes_cavalos[5] = {"🐎 JAILTON                    ", "🐎 VAGABUNDO DAS ESTRELAS     ", "🐎 PÉ DE PANO                 ", "🐎 CASEMIRO                   ", "🐎 PANGARÉ                    "}
    inteiro posicoes[5] = {0, 0, 0, 0, 0}
    inteiro odds_cavalos[5] = {3, 4, 2, 5, 3}
    inteiro meta = 50
    logico corrida_ativa = falso
    inteiro vitoriasHipica = 0
    inteiro derrotasHipica = 0
    inteiro aposta_cavalos_global = 0
    inteiro cavalo_apostado_global = 0
    
    // ========== VARIÁVEIS ESPECÍFICAS DO FUTEBOL ==========
    cadeia times[6] = {"🦩 FLAMENGO", "👴 SÃO PAULO", "🐓 ATLETICO MG", "🐷 PALMEIRAS", "🐟 SANTOS", "🏳️‍🌈 CRUZEIRO"}
    inteiro odds_futebol[3] = {25, 32, 28} // [Casa*10, Empate*10, Visitante*10] para simular decimais
    inteiro placar_casa = 0
    inteiro placar_visitante = 0
    inteiro minuto_jogo = 0
    logico jogo_ativo = falso
    inteiro vitoriasF = 0
    inteiro derrotasF = 0
    inteiro aposta_futebol_global = 0
    inteiro resultado_apostado_global = 0 // 1=Casa, 2=Empate, 3=Visitante
    inteiro time_casa_global = 0
    inteiro time_visitante_global = 0
    
    // ========== FUNÇÃO PRINCIPAL ==========
    funcao inicio()
    {
        mostrar_abertura()
        escreva("👤 DIGITE SEU NOME: ")
        leia(nomeJogador)
        limpa()
        escreva("\n🎰 BEM-VINDO AO CASSINO, ", nomeJogador, "! 🎰\n")
        menu_principal()
        
    }
    
    // ========== FUNÇÃO QUE MOSTRA A TELA DE ABERTURA ==========
    funcao mostrar_abertura()
    {
        escreva("╔══════════════════════════════════════════════════════════╗\n")
        escreva("║                 🎰 CASSINO VAGABUNDO 🎰                 ║\n")
        escreva("║                                                          ║\n")
        escreva("║                     TESTE SUA SORTE                      ║\n")
        escreva("║                                                          ║\n")
        escreva("║              ★ O MELHOR CASSINO VIRTUAL ★               ║\n")
        escreva("╚══════════════════════════════════════════════════════════╝\n\n")
    }
    
    // ========== FUNÇÃO DO MENU PRINCIPAL DO CASSINO ==========
    funcao menu_principal()
    {
        inteiro opcao
        
        enquanto (verdadeiro)
        {
            escreva("\n", repetir_char('=', 60), "\n")
            escreva("🎰               CASSINO VAGABUNDO - MENU PRINCIPAL              🎰\n")
            escreva("👤 JOGADOR: ", nomeJogador, " | 💰 SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
            escreva(repetir_char('=', 60), "\n")

            escreva("🏪 1 - COMPRAR FICHAS\n")
            escreva("🃏 2 - BLACKJACK (21)\n")
            escreva("🏇 3 - CORRIDA DE CAVALOS\n")
            escreva("⚽ 4 - BRASFUT\n")
            escreva("💰 5 - VER SALDO E ESTATÍSTICAS\n")
            escreva("🚪 0 - CORRER DO VAGABUNDO\n")
            escreva(repetir_char('=', 60), "\n")
            escreva("🎲 ESCOLHA SUA OPÇÃO: ")
            
            leia(opcao)
            limpa()
            
            escolha (opcao)
            {
                caso 1:
                    comprar_fichas()
                    pare
                caso 2:
                    iniciar_blackjack()
                    pare
                caso 3:
                    iniciar_corrida_cavalos()
                    pare
                caso 4:
                    iniciar_futebol()
                    pare
                caso 5:
                    mostrar_estatisticas()
                    pare
                caso 0:
                    finalizar_cassino()
                    retorne
                caso contrario:
                    escreva("❌ OPÇÃO INVÁLIDA! TENTE NOVAMENTE.\n")
            }
            
            cadeia pausa
            escreva("\n⏸️ PRESSIONE ENTER PARA VOLTAR AO MENU PRINCIPAL...")
            leia(pausa)
            limpa()
        }
    }
    
    // ========== FUNÇÃO PARA COMPRAR FICHAS ==========
    funcao comprar_fichas()
    {
        inteiro fichas
        
        escreva("\n💳 === COMPRA DE FICHAS === 💳\n")
        escreva("🎫 PREÇO: R$ 10 POR FICHA\n")
        escreva("💰 SALDO ATUAL: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
        escreva("🛒 QUANTAS FICHAS DESEJA COMPRAR? ")
        leia(fichas)
        
        enquanto (fichas <= 0)
        {
            escreva("❌ NÚMERO INVÁLIDO! DIGITE PELO MENOS 1 FICHA: ")
            leia(fichas)
        }
        
        dinheiroTotal = dinheiroTotal + (fichas * 10)
        escreva("✅ VOCÊ COMPROU ", fichas, " FICHAS POR R$ ", fichas * 10, "\n")
        escreva("💰 NOVO SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
    }
    
    // ========== FUNÇÃO QUE MOSTRA AS ESTATÍSTICAS DETALHADAS ==========
    funcao mostrar_estatisticas()
    {
        escreva("\n📊 === ESTATÍSTICAS DO CASSINO === 📊\n")
        escreva("👤 JOGADOR: ", nomeJogador, "\n")
        escreva("💰 SALDO TOTAL: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n\n")
        
        escreva("🃏 BLACKJACK:\n")
        escreva("   🏆 VITÓRIAS: ", vitoriasBlack, "\n")
        escreva("   💀 DERROTAS: ", derrotasBlack, "\n\n")
        
        escreva("🏇 CORRIDA DE CAVALOS:\n")
        escreva("   🏆 VITÓRIAS: ", vitoriasHipica, "\n")
        escreva("   💀 DERROTAS: ", derrotasHipica, "\n\n")
        
        escreva("⚽ BRASFUT:\n")
        escreva("   🏆 VITÓRIAS: ", vitoriasF, "\n")
        escreva("   💀 DERROTAS: ", derrotasF, "\n\n")
        
        inteiro totalJogos = vitoriasBlack + derrotasBlack + vitoriasHipica + derrotasHipica + vitoriasF + derrotasF
        inteiro totalVitorias = vitoriasBlack + vitoriasHipica + vitoriasF
        
        se (totalJogos > 0)
        {
            escreva("📈 RESUMO GERAL:\n")
            escreva("   🎮 TOTAL DE JOGOS: ", totalJogos, "\n")
            escreva("   🏆 TOTAL DE VITÓRIAS: ", totalVitorias, "\n")
            escreva("   💀 TOTAL DE DERROTAS: ", (totalJogos - totalVitorias), "\n")
            escreva("   📊 TAXA DE VITÓRIA: ", (totalVitorias * 100 / totalJogos), "%\n")
        }
        
        se (dinheiroTotal >= 12000)
        {
            escreva("\n🎉🎉🎉 PARABÉNS!!! 🎉🎉🎉\n")
            escreva("É HORA DE COMPRAR SUA PLACA DE VÍDEO!\n")
        }
    }
    
    // ========== FUNÇÃO QUE ENCERRA O CASSINO ==========
    funcao finalizar_cassino()
    {
        escreva("\n🎰 === OBRIGADO POR JOGAR NO CASSINO VAGUNDO === 🎰\n")
        escreva("👤 JOGADOR: ", nomeJogador, "\n")
        escreva("💰 SALDO FINAL: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
        escreva("🏆 VITÓRIAS TOTAIS: ", (vitoriasBlack + vitoriasHipica + vitoriasF), "\n")
        escreva("💀 DERROTAS TOTAIS: ", (derrotasBlack + derrotasHipica + derrotasF), "\n")
        escreva("\n🎲 VOLTE SEMPRE! A SORTE PODE MUDAR! 🍀\n")
    }
    
    // =========================================================================
    // ========================= SEÇÃO BLACKJACK ==============================
    // =========================================================================
    
    funcao iniciar_blackjack()
    {
        escreva("\n💀💀💀  BLACKJACK  💀💀💀\n\n")
        
        se (dinheiroTotal <= 0)
        {
            escreva("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!\n")
            retorne
        }
        
        inteiro fichasApostadas
        escreva("💵 SALDO ATUAL: R$ ", dinheiroTotal, " (", dinheiroTotal / 10, " FICHAS)\n")
        escreva("🎲 QUANTAS FICHAS DESEJA APOSTAR? ")
        leia(fichasApostadas)
        limpa()
        
        enquanto (fichasApostadas <= 0 ou fichasApostadas > (dinheiroTotal / 10))
        {
            escreva("⚠️ APOSTA INVÁLIDA. DIGITE UM NÚMERO DE FICHAS ENTRE 1 E ", dinheiroTotal/10, ": ")
            leia(fichasApostadas)
            limpa()
        }
        
        inteiro aposta = fichasApostadas * 10
        rodada_blackjack(aposta)
    }
    
    funcao rodada_blackjack(inteiro aposta)
    {
        proximaCarta = 0
        preencheBaralho()
        embaralhaBaralho()
        
        inteiro somaJogador = jogarJogador()
        inteiro somaDealer = jogarDealerInteligente(somaJogador) // DEALER INTELIGENTE!
        mostrarResultadoBlack(somaJogador, somaDealer, aposta)
    }
    
    funcao inteiro jogarJogador()
    {
        inteiro soma = 0
        inteiro i = 1
        caracter opcao
        logico ativo = verdadeiro
        
        enquanto (ativo)
        {
            inteiro valor = baralhoValor[proximaCarta]
            inteiro naipe = baralhoNaipe[proximaCarta]
            proximaCarta = proximaCarta + 1
            
            escreva("SUA ", i, "° CARTA: ", mostrarCarta(valor, naipe), "\n")
            soma = soma + valorCartaJogador(valor, soma)
            escreva("TOTAL ATUAL: ", soma, "\n\n")
            
            se (soma >= 21)
            {
                se (soma > 21)
                    escreva("🏢🏢💥🛩 VOCÊ ESTOUROU! PASSOU DE 21.\n")
                senao
                    escreva("👏🏼 PARABÉNS! VOCÊ FEZ 21!\n")
                ativo = falso
                pare
            }
            
            escreva("DESEJA PEDIR MAIS UMA CARTA? (S/N): ")
            leia(opcao)
            limpa()
            
            se (opcao == 'n' ou opcao == 'N')
                ativo = falso
                
            i = i + 1
        }
        
        retorne soma
    }
    
    // ========== DEALER INTELIGENTE ==========
    funcao inteiro jogarDealerInteligente(inteiro somaJogador)
    {
        escreva("\n⏳ VEZ DO DEALER ⏳\n\n")
        
        inteiro soma = 0
        inteiro i = 1
        
        // Primeira rodada: dealer sempre pega cartas até 17 (regra padrão)
        enquanto (soma < 17)
        {
            u.aguarde(1500)
            
            inteiro valor = baralhoValor[proximaCarta]
            inteiro naipe = baralhoNaipe[proximaCarta]
            proximaCarta = proximaCarta + 1
            
            escreva(i, "° CARTA DO DEALER: ", mostrarCarta(valor, naipe), "\n")
            soma = soma + valorCartaDealer(valor, soma)
            escreva("TOTAL DO DEALER: ", soma, "\n\n")
            
            
            
            se (soma > 21)
            {
                escreva("DEALER ESTOUROU! PASSOU DE 21.\n")
                retorne soma
            }
            
            i = i + 1
        }
        
        // ========== INTELIGÊNCIA DO DEALER ==========
        // Se o jogador não estourou, dealer analisa se deve arriscar mais
        se (somaJogador <= 21 e soma < somaJogador e soma >= 17)
        {
            escreva("🤖 DEALER ANALISANDO A SITUAÇÃO...\n")
            u.aguarde(1500)
            
            // Lógica de decisão do dealer inteligente
            logico deveArriscar = falso
            
            se (somaJogador == 21)
            {
                // Se jogador tem 21, dealer sempre arrisca (a não ser que também tenha 21)
                se (soma < 21)
                {
                    escreva("💭 'O jogador tem 21... preciso arriscar!'\n")
                    deveArriscar = verdadeiro
                }
            }
            senao se (somaJogador >= 19 e soma < somaJogador)
            {
                // Se jogador tem 19-20, dealer arrisca com 80% de chance
                inteiro chance = u.sorteia(1, 100)
                se (chance <= 80)
                {
                    escreva("💭 'Jogador está com ", somaJogador, "... vou arriscar!'\n")
                    deveArriscar = verdadeiro
                }
                senao
                {
                    escreva("💭 'Muito arriscado... vou ficar com ", soma, "'\n")
                }
            }
            senao se (somaJogador >= 18 e soma < somaJogador)
            {
                // Se jogador tem 18, dealer arrisca com 60% de chance
                inteiro chance = u.sorteia(1, 100)
                se (chance <= 60)
                {
                    escreva("💭 'Posso tentar uma carta...'\n")
                    deveArriscar = verdadeiro
                }
                senao
                {
                    escreva("💭 'Melhor não arriscar demais'\n")
                }
            }
            senao se (soma < somaJogador)
            {
                // Para outros casos, dealer arrisca com 40% de chance
                inteiro chance = u.sorteia(1, 100)
                se (chance <= 40)
                {
                    escreva("💭 'Vou tentar mais uma...'\n")
                    deveArriscar = verdadeiro
                }
            }
            
            // Se decidir arriscar, pega mais cartas com estratégia
            se (deveArriscar)
            {
                enquanto (soma < somaJogador e soma < 21)
                {
                    u.aguarde(1800)
                    
                    inteiro valor = baralhoValor[proximaCarta]
                    inteiro naipe = baralhoNaipe[proximaCarta]
                    proximaCarta = proximaCarta + 1
                    
                    escreva(i, "° CARTA DO DEALER (ARRISCANDO): ", mostrarCarta(valor, naipe), "\n")
                    soma = soma + valorCartaDealer(valor, soma)
                    escreva("TOTAL DO DEALER: ", soma, "\n\n")
                    
                    se (soma > 21)
                    {
                        escreva("💥 DEALER ARRISCOU E ESTOUROU!\n")
                        pare
                    }
                    senao se (soma >= somaJogador)
                    {
                        escreva("😎 DEALER CONSEGUIU TE ALCANÇAR!\n")
                        pare
                    }
                    senao
                    {
                        // Dealer para se a próxima carta provavelmente o fará estourar
                        inteiro cartas_altas = 0 // Contar quantas cartas 10, J, Q, K ainda podem vir
                        inteiro limite_seguro = 21 - soma
                        
                        se (limite_seguro <= 4) // Se só pode receber até 4, chance alta de estourar
                        {
                            inteiro chance_parar = u.sorteia(1, 100)
                            se (chance_parar <= 70) // 70% chance de parar quando arriscado
                            {
                                escreva("💭 'Muito perigoso continuar... vou parar aqui'\n")
                                pare
                            }
                        }
                    }

                    
                    i = i + 1
                }
            }
        }
        
        u.aguarde(2000)
        retorne soma
    }
    
    funcao mostrarResultadoBlack(inteiro somaJogador, inteiro somaDealer, inteiro aposta)
    {
        escreva("\n📊 RESULTADO FINAL 📊\n")
        escreva("SEUS PONTOS: ", somaJogador, "\n")
        escreva("PONTOS DO DEALER: ", somaDealer, "\n")
        u.aguarde(2000)
        
        se (somaJogador > 21 e somaDealer > 21)
        {
            escreva("\n🤝 EMPATE! AMBOS ESTOURARAM.\n")
        }
        senao se (somaJogador > 21)
        {
            escreva("\n💥 VOCÊ PERDEU! ESTOUROU.\n")
            dinheiroTotal = dinheiroTotal - aposta
            derrotasBlack = derrotasBlack + 1
        }
        senao se (somaDealer > 21)
        {
            escreva("\n🏆 VOCÊ VENCEU! O DEALER ESTOUROU.\n")
            dinheiroTotal = dinheiroTotal + aposta
            vitoriasBlack = vitoriasBlack + 1
        }
        senao se (somaJogador > somaDealer)
        {
            escreva("\n🏆 VOCÊ VENCEU! TEM MAIS PONTOS.\n")
            dinheiroTotal = dinheiroTotal + aposta
            vitoriasBlack = vitoriasBlack + 1
        }
        senao se (somaJogador < somaDealer)
        {
            escreva("\n💀 VOCÊ PERDEU! O DEALER TEM MAIS PONTOS.\n")
            dinheiroTotal = dinheiroTotal - aposta
            derrotasBlack = derrotasBlack + 1
        }
        senao
        {
            escreva("\n🤝 EMPATE! MESMA PONTUAÇÃO.\n")
        }
        
        escreva("\n💰 SALDO ATUAL: R$ ", dinheiroTotal, " (", dinheiroTotal / 10, " FICHAS)\n")
    }
    
    // =========================================================================
    // ========================= SEÇÃO CORRIDA DE CAVALOS =========================
    // =========================================================================
    
    funcao iniciar_corrida_cavalos()
    {
        escreva("\n🏇 === BEM-VINDO AO HIPÓDROMO === 🏇\n")
        
        se (dinheiroTotal <= 0)
        {
            escreva("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!\n")
            retorne
        }
        
        menu_hipica()
        limpa()
    }
    
    funcao menu_hipica()
    {
        inteiro opcao
        
        enquanto (verdadeiro)
        {
            escreva("\n", repetir_char('=', 50), "\n")
            escreva("🏇 HIPÓDROMO VAGABUNDO 🏇\n")
            escreva("💰 SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
            
            se (aposta_cavalos_global > 0)
            {
                escreva("🎯 APOSTA ATUAL: ", nomes_cavalos[cavalo_apostado_global-1], " - R$ ", aposta_cavalos_global, "\n")
            }
            
            escreva(repetir_char('=', 50), "\n")
            
            escreva("1. 📋 VER CAVALOS E ODDS\n")
            escreva("2. 💸 FAZER APOSTA\n")
            escreva("3. 🏁 INICIAR CORRIDA\n")
            escreva("0. 🔙 VOLTAR AO MENU PRINCIPAL\n")
            escreva(repetir_char('=', 50), "\n")
            escreva("ESCOLHA UMA OPÇÃO: ")
            
            leia(opcao)
            limpa ()
            
            escolha(opcao) {
                caso 1:
                    mostrar_cavalos()
                    pare
                caso 2:
                    se (nao corrida_ativa)
                    {
                        fazer_aposta_cavalos()
                    }
                    senao
                    {
                        escreva("❌ NÃO É POSSÍVEL APOSTAR DURANTE A CORRIDA!\n")
                    }
                    pare
                    limpa ()
                caso 3:
                    se (aposta_cavalos_global > 0)
                    {
                        iniciar_corrida_completa(aposta_cavalos_global, cavalo_apostado_global)
                        aposta_cavalos_global = 0
                        cavalo_apostado_global = 0
                    }
                    senao
                    {
                        escreva("❌ VOCÊ PRECISA FAZER UMA APOSTA PRIMEIRO!\n")
                    }
                    pare
                    limpa ()
                caso 0:
                    retorne
                caso contrario:
                    escreva("❌ OPÇÃO INVÁLIDA!\n")
                    limpa ()
            }
            
            cadeia pausa
            escreva("\nPRESSIONE ENTER PARA CONTINUAR...")
            leia(pausa)
            limpa()
        }
    }
    
    funcao mostrar_cavalos()
    {
        escreva("\n🏇 === CAVALOS PARTICIPANTES === 🏇\n")
        
        para(inteiro i = 0; i < 5; i++) {
            escreva("CAVALO ", (i+1), ": ", nomes_cavalos[i])
            escreva(" | ODD: ", odds_cavalos[i], "X")
            
            se(odds_cavalos[i] == 2) 
                escreva(" (FAVORITO)")
            senao se(odds_cavalos[i] >= 4) 
                escreva(" (AZARÃO)")
            escreva("\n")
        }
    }
    
    funcao fazer_aposta_cavalos()
    {
        mostrar_cavalos()
        
        escreva("\n💰 SEU SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
        escreva("EM QUAL CAVALO DESEJA APOSTAR (1-5)? ")
        
        inteiro cavalo_apostado
        leia(cavalo_apostado)
        
        se(cavalo_apostado < 1 ou cavalo_apostado > 5) {
            escreva("❌ CAVALO INVÁLIDO!\n")
            aposta_cavalos_global = 0
            cavalo_apostado_global = 0
            retorne
        }
        
        escreva("QUANTAS FICHAS DESEJA APOSTAR? ")
        inteiro fichas_apostadas
        leia(fichas_apostadas)
        limpa ()
        
        se(fichas_apostadas <= 0 ou fichas_apostadas > (dinheiroTotal / 10)) {
            escreva("❌ VALOR DE APOSTA INVÁLIDO!\n")
            aposta_cavalos_global = 0
            cavalo_apostado_global = 0
            limpa ()
            retorne
        }
        
        inteiro aposta = fichas_apostadas * 10
        dinheiroTotal = dinheiroTotal - aposta
        
        escreva("\n✅ APOSTA CONFIRMADA!\n")
        escreva("🏇 CAVALO: ", nomes_cavalos[cavalo_apostado-1], "\n")
        escreva("💰 VALOR: R$ ", aposta, " (", fichas_apostadas, " FICHAS)\n")
        escreva("🎯 RETORNO POTENCIAL: R$ ", (aposta * odds_cavalos[cavalo_apostado-1]), "\n")
        escreva("💳 SALDO RESTANTE: R$ ", dinheiroTotal, "\n")
        
        aposta_cavalos_global = aposta
        cavalo_apostado_global = cavalo_apostado
    }
    
    funcao iniciar_corrida_completa(inteiro aposta, inteiro cavalo_apostado)
    {
        corrida_ativa = verdadeiro
        
        para(inteiro i = 0; i < 5; i++) {
            posicoes[i] = 0
        }
        
        escreva("\n🏁 === INICIANDO A CORRIDA === 🏁\n")
        escreva("🔥 SUA APOSTA: ", nomes_cavalos[cavalo_apostado-1], " - R$ ", aposta, "\n\n")
        
        para(inteiro i = 3; i >= 1; i--) {
            escreva(i, "... ")
            u.aguarde(1000)
        }
        escreva("🏁 LARGADA!\n\n")
        u.aguarde(1000)
        
        inteiro vencedor = 0
        enquanto(vencedor == 0) {
            para(inteiro i = 0; i < 5; i++) {
                inteiro avanco = u.sorteia(1, 4)
                posicoes[i] = posicoes[i] + avanco
                
                se(posicoes[i] >= meta e vencedor == 0) {
                    vencedor = i + 1
                }
            }
            limpa()
            mostrar_pista()
            
            u.aguarde(1500)
        }
        
        processar_resultado_cavalos(vencedor, aposta, cavalo_apostado)
        corrida_ativa = falso
    }
    
    funcao mostrar_pista()
{
    escreva("\n📍 POSIÇÕES:\n")
    
    para(inteiro i = 0; i < 5; i++) {
        escreva(nomes_cavalos[i], ": ")
        
        inteiro pos_visual = (posicoes[i] * 30) / meta

        // Garante que não ultrapasse a pista visual
        se (pos_visual > 29) {
            pos_visual = 29
        }

        para(inteiro j = 0; j < 30; j++) {
          
            se(posicoes[i] >= meta e j == 29) {
                escreva("🏆") // Mostra o troféu no fim da linha se já venceu
            } senao se(j == pos_visual) {
                escreva("🏇") // Cavalo em movimento
            } senao se(j == 29) {
                escreva("🏁") // Linha de chegada
            } senao {
                escreva("-") // Pista normal
            }                 
        }

        escreva("\n")
        
    }
}

    
    funcao processar_resultado_cavalos(inteiro vencedor, inteiro aposta, inteiro cavalo_apostado)
    {
        escreva("\n", repetir_char('=', 50), "\n")
        escreva("🏆 RESULTADO FINAL 🏆\n")
        escreva(repetir_char('=', 50), "\n")
        escreva("🥇 VENCEDOR: ", nomes_cavalos[vencedor-1], "\n")
        
        se(vencedor == cavalo_apostado) {
            inteiro premio = aposta * odds_cavalos[cavalo_apostado-1]
            dinheiroTotal = dinheiroTotal + premio
            vitoriasHipica = vitoriasHipica + 1
            
            escreva("\n🎉 PARABÉNS! VOCÊ GANHOU! 🎉\n")
            escreva("💰 PRÊMIO: R$ ", premio, "\n")
            escreva("💳 NOVO SALDO: R$ ", dinheiroTotal, "\n")
        } senao {
            derrotasHipica = derrotasHipica + 1
            
            escreva("\n😔 QUE PENA! VOCÊ PERDEU DESTA VEZ.\n")
            escreva("🏇 VOCÊ APOSTOU EM: ", nomes_cavalos[cavalo_apostado-1], "\n")
            escreva("💸 VALOR PERDIDO: R$ ", aposta, "\n")
            escreva("💳 SALDO ATUAL: R$ ", dinheiroTotal, "\n")
        }
    }
    
    // =========================================================================
    // ===================== SEÇÃO APOSTAS DE FUTEBOL =======================
    // =========================================================================
    
    funcao iniciar_futebol()
    {
        escreva("\n⚽ === BEM-VINDO ÀS APOSTAS DE FUTEBOL === ⚽\n")
        
        se (dinheiroTotal <= 0)
        {
            escreva("❌ VOCÊ PRECISA COMPRAR FICHAS PRIMEIRO!\n")
            retorne
        }
        
        menu_futebol()
    }
    
    funcao menu_futebol()
    {
        inteiro opcao
        
        enquanto (verdadeiro)
        {
            escreva("\n", repetir_char('=', 55), "\n")
            escreva("⚽ CASA DE APOSTAS - FUTEBOL BRASILEIRO ⚽\n")
            escreva("💰 SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
            
            se (aposta_futebol_global > 0)
            {
                cadeia resultado_str = ""
                se (resultado_apostado_global == 1)
                    resultado_str = "VITÓRIA " + times[time_casa_global]
                senao se (resultado_apostado_global == 2)
                    resultado_str = "EMPATE"
                senao
                    resultado_str = "VITÓRIA " + times[time_visitante_global]
                    
                escreva("🎯 APOSTA ATUAL: ", resultado_str, " - R$ ", aposta_futebol_global, "\n")
            }
            
            escreva(repetir_char('=', 55), "\n")
            
            escreva("1. 📊 VER PRÓXIMO JOGO E ODDS\n")
            escreva("2. 💸 FAZER APOSTA\n")
            escreva("3. ⚽ ASSISTIR AO JOGO\n")
            escreva("0. 🔙 VOLTAR AO MENU PRINCIPAL\n")
            escreva(repetir_char('=', 55), "\n")
            escreva("ESCOLHA UMA OPÇÃO: ")
            
            leia(opcao)
            
            escolha(opcao) {
                caso 1:
                    mostrar_jogo_e_odds()
                    pare
                caso 2:
                    se (nao jogo_ativo)
                    {
                        fazer_aposta_futebol()
                    }
                    senao
                    {
                        escreva("❌ NÃO É POSSÍVEL APOSTAR DURANTE O JOGO!\n")
                    }
                    pare
                caso 3:
                    se (aposta_futebol_global > 0)
                    {
                        iniciar_jogo_futebol()
                        // Reset completo após o jogo
                        aposta_futebol_global = 0
                        resultado_apostado_global = 0
                        time_casa_global = 0
                        time_visitante_global = 0
                    }
                    senao
                    {
                        escreva("❌ VOCÊ PRECISA FAZER UMA APOSTA PRIMEIRO!\n")
                    }
                    pare
                caso 0:
                    retorne
                caso contrario:
                    escreva("❌ OPÇÃO INVÁLIDA!\n")
            }
            
            cadeia pausa
            escreva("\nPRESSIONE ENTER PARA CONTINUAR...")
            leia(pausa)
        }
    }
    
    funcao mostrar_jogo_e_odds()
    {
        // Só sorteia novos times se ainda não foram definidos
        se (time_casa_global == 0 e time_visitante_global == 0)
        {
            inteiro casa = u.sorteia(0, 5)
            inteiro visitante
            
            faca {
                visitante = u.sorteia(0, 5)
            } enquanto (visitante == casa)
            
            // Armazena os times globalmente
            time_casa_global = casa
            time_visitante_global = visitante
        }
        
        escreva("\n⚽ === PRÓXIMO JOGO === ⚽\n")
        escreva("🏠 CASA: ", times[time_casa_global], "\n")
        escreva("✈️ VISITANTE: ", times[time_visitante_global], "\n\n")
        
        escreva("📊 === ODDS DE APOSTAS === 📊\n")
        escreva("1. VITÓRIA ", times[time_casa_global], " ---- 2.5X\n")
        escreva("2. EMPATE ------------------- 3.2X\n")
        escreva("3. VITÓRIA ", times[time_visitante_global], " ---- 2.8X\n\n")
        
        escreva("💡 DICA: Odds menores = maior probabilidade, menor prêmio\n")
        escreva("💡 DICA: Odds maiores = menor probabilidade, maior prêmio\n")
    }
    
    funcao fazer_aposta_futebol()
    {
        mostrar_jogo_e_odds()
        
        escreva("\n💰 SEU SALDO: R$ ", dinheiroTotal, " (", dinheiroTotal/10, " FICHAS)\n")
        escreva("EM QUE RESULTADO DESEJA APOSTAR (1-3)? ")
        
        inteiro resultado_apostado
        leia(resultado_apostado)
        
        se(resultado_apostado < 1 ou resultado_apostado > 3) {
            escreva("❌ RESULTADO INVÁLIDO!\n")
            aposta_futebol_global = 0
            resultado_apostado_global = 0
            retorne
        }
        
        escreva("QUANTAS FICHAS DESEJA APOSTAR? ")
        inteiro fichas_apostadas
        leia(fichas_apostadas)
        
        se(fichas_apostadas <= 0 ou fichas_apostadas > (dinheiroTotal / 10)) {
            escreva("❌ VALOR DE APOSTA INVÁLIDO!\n")
            aposta_futebol_global = 0
            resultado_apostado_global = 0
            retorne
        }
        
        inteiro aposta = fichas_apostadas * 10
        dinheiroTotal = dinheiroTotal - aposta
        
        escreva("\n✅ APOSTA CONFIRMADA!\n")
        
        se (resultado_apostado == 1)
            escreva("⚽ APOSTA: VITÓRIA ", times[time_casa_global], "\n")
        senao se (resultado_apostado == 2)
            escreva("⚽ APOSTA: EMPATE\n")
        senao
            escreva("⚽ APOSTA: VITÓRIA ", times[time_visitante_global], "\n")
            
        escreva("💰 VALOR: R$ ", aposta, " (", fichas_apostadas, " FICHAS)\n")
        
        // Cálculo do retorno potencial (odds * 10 para simular decimais)
        inteiro retorno_potencial = (aposta * odds_futebol[resultado_apostado-1]) / 10
        escreva("🎯 RETORNO POTENCIAL: R$ ", retorno_potencial, "\n")
        escreva("💳 SALDO RESTANTE: R$ ", dinheiroTotal, "\n")
        
        aposta_futebol_global = aposta
        resultado_apostado_global = resultado_apostado
    }
    
    funcao iniciar_jogo_futebol()
    {
        jogo_ativo = verdadeiro
        placar_casa = 0
        placar_visitante = 0
        minuto_jogo = 0
        
        escreva("\n⚽ === JOGO INICIANDO === ⚽\n")
        escreva("🏠 ", times[time_casa_global], " 0 x 0 ", times[time_visitante_global], " ✈️\n\n")
        
        se (resultado_apostado_global == 1)
            escreva("🎯 SUA APOSTA: VITÓRIA ", times[time_casa_global], " (2.5X)\n\n")
        senao se (resultado_apostado_global == 2)
            escreva("🎯 SUA APOSTA: EMPATE (3.2X)\n\n")
        senao
            escreva("🎯 SUA APOSTA: VITÓRIA ", times[time_visitante_global], " (2.8X)\n\n")
        
        escreva("🔴 O JOGO COMEÇOU! 🔴\n")
        u.aguarde(2000)
        
        // Simulação do jogo com eventos
        enquanto (minuto_jogo < 90)
        {
            inteiro evento = u.sorteia(1, 100)
            inteiro avanco_tempo = u.sorteia(3, 8)
            minuto_jogo = minuto_jogo + avanco_tempo
            
            se (minuto_jogo > 90)
                minuto_jogo = 90
            
            // Diferentes tipos de eventos durante o jogo
            se (evento <= 20) // 8% chance de gol
            {
                inteiro quem_marca = u.sorteia(1, 2)
                se (quem_marca == 1)
                {
                    placar_casa = placar_casa + 1
                    escreva("⚽ ", minuto_jogo, "' GOOOOOOL! ", times[time_casa_global], "!\n")
                }
                senao
                {
                    placar_visitante = placar_visitante + 1
                    escreva("⚽ ", minuto_jogo, "' GOOOOOOL! ", times[time_visitante_global], "!\n")
                }
                escreva("📊 PLACAR: ", times[time_casa_global], " ", placar_casa, " x ", placar_visitante, " ", times[time_visitante_global], "\n\n")
                u.aguarde(3000)
            }
            senao se (evento <= 15) // 7% chance de cartão
            {
                inteiro tipo_cartao = u.sorteia(1, 2)
                inteiro time_cartao = u.sorteia(1, 2)
                
                se (tipo_cartao == 1)
                {
                    escreva("🟨 ", minuto_jogo, "' CARTÃO AMARELO para ")
                    se (time_cartao == 1)
                        escreva(times[time_casa_global])
                    senao
                        escreva(times[time_visitante_global])
                    escreva("\n\n")
                }
                senao
                {
                    escreva("🟥 ", minuto_jogo, "' CARTÃO VERMELHO! ")
                    se (time_cartao == 1)
                        escreva(times[time_casa_global], " FICA COM UM JOGADOR A MENOS!\n\n")
                    senao
                        escreva(times[time_visitante_global], " FICA COM UM JOGADOR A MENOS!\n\n")
                }
                u.aguarde(2000)
            }
            senao se (evento <= 25) // 10% chance de eventos especiais
            {
                inteiro evento_especial = u.sorteia(1, 7)
                
                escolha (evento_especial)
                {
                    caso 1:
                        escreva("🚫 ", minuto_jogo, "O ",times[time_casa_global]," TEM UM' PÊNALTI PERDIDO! DEFESA DO GOLEIRO!\n\n")
                        pare
                    caso 2:
                        escreva("🥅 ", minuto_jogo, "' QUE DEFESA! O GOLEIRO DO ",times[time_casa_global]," FEZ UMA DEFESA ESPETACULAR!\n\n")
                        pare
                    caso 3:
                        escreva("🏃 ", minuto_jogo, "' CONTRA ATAQUE PERIGOSO DO ",times[time_casa_global],", MAS A DEFESA CONSEGUE CORTAR!\n\n")
                        pare
                    caso 4:
                        escreva("⚡ ", minuto_jogo, "' CHUTE FORTE DO ",times[time_casa_global],"! A BOLA EXPLODIU NA TRAVE!\n\n")
                        pare
                    caso 5:
                        escreva("🤕 ", minuto_jogo, "' JOGADOR DO ", times[time_casa_global], " CAI SENTINDO DORES APÓS UMA DIVIDIDA! MÉDICOS EM CAMPO.\n\n")
                        pare

                    caso 6:
                        escreva("📢 ", minuto_jogo, "' A TORCIDA DO ", times[time_casa_global], " VAI À LOUCURA COM A PRESSÃO DO TIME!\n\n")
                        pare

                    caso 7:
                        escreva("🎯 ", minuto_jogo, "' FINALIZAÇÃO MILIMÉTRICA DO ", times[time_casa_global], ", MAS O GOLEIRO FAZ UMA DEFESA SEGURA!\n\n")
                        pare

                }
                u.aguarde(2500)
            }
            senao se (evento <= 35) // 10% chance de narração geral
            {
                inteiro narracao = u.sorteia(1, 3)
                
                escolha (narracao)
                {
                    caso 1:
                        escreva("📺 ", minuto_jogo, "' BELA JOGADA DO ", times[time_casa_global], ", MAS NÃO RESULTOU EM GOL...\n\n")
                        pare
                    caso 2:
                        escreva("📺 ", minuto_jogo, "' DISPULTA INTENSA NO MEIO CAMPO!\n\n")
                        pare
                    caso 3:
                        escreva("📺 ", minuto_jogo, "' O JOGO ESTÁ EQUILIBRADO!\n\n")
                        pare
                }
                u.aguarde(1500)
            }
            // Senão, o tempo apenas passa (65% das vezes)
            
            // Mostra o tempo a cada 15 minutos (aproximadamente)
            se (minuto_jogo >= 15 e minuto_jogo <= 20 e evento > 80)
                escreva("⏰ ", minuto_jogo, "' - PRIMEIRO TEMPO FRACO...\n\n")
            senao se (minuto_jogo >= 45 e minuto_jogo <= 48 e evento > 90)
                escreva("⏰ FIM DO PRIMEIRO TEMPO! INTERVALO.\n\n")
            senao se (minuto_jogo >= 70 e minuto_jogo <= 75 e evento > 85)
                escreva("⏰ ", minuto_jogo, "' - JOGO BEM FRACO!\n\n")
                
            u.aguarde(800) // Pausa entre eventos
        }
        
        // Final do jogo
        escreva("🏁 ⏰ FIM DE JOGO! ⏰ 🏁\n")
        escreva("📊 RESULTADO FINAL: ", times[time_casa_global], " ", placar_casa, " x ", placar_visitante, " ", times[time_visitante_global], "\n\n")
        
        processar_resultado_futebol()
        jogo_ativo = falso
    }
    
    funcao processar_resultado_futebol()
    {
        inteiro resultado_real = 0
        
        // Determina o resultado real do jogo
        se (placar_casa > placar_visitante)
            resultado_real = 1 // Casa venceu
        senao se (placar_casa == placar_visitante)
            resultado_real = 2 // Empate
        senao
            resultado_real = 3 // Visitante venceu
        
        escreva(repetir_char('=', 55), "\n")
        escreva("⚽ RESULTADO DAS APOSTAS ⚽\n")
        escreva(repetir_char('=', 55), "\n")
        
        // Mostra o resultado em texto
        se (resultado_real == 1)
            escreva("🏆 RESULTADO: VITÓRIA ", times[time_casa_global], "\n")
        senao se (resultado_real == 2)
            escreva("🤝 RESULTADO: EMPATE\n")
        senao
            escreva("🏆 RESULTADO: VITÓRIA ", times[time_visitante_global], "\n")
        
        // Verifica se o jogador ganhou
        se (resultado_real == resultado_apostado_global)
        {
            // VITÓRIA!
            inteiro premio = aposta_futebol_global * odds_futebol[resultado_apostado_global-1]
            dinheiroTotal = dinheiroTotal + premio
            vitoriasF = vitoriasF + 1
            
            escreva("\n🎉 PARABÉNS! VOCÊ ACERTOU! 🎉\n")
            escreva("💰 PRÊMIO: R$ ", premio, "\n")
            escreva("💳 NOVO SALDO: R$ ", dinheiroTotal, "\n")
        }
        senao
        {
            // DERROTA
            derrotasF = derrotasF + 1
            
            escreva("\n😔 QUE PENA! VOCÊ ERROU DESTA VEZ.\n")
            
            se (resultado_apostado_global == 1)
                escreva("🎯 VOCÊ APOSTOU EM: VITÓRIA ", times[time_casa_global], "\n")
            senao se (resultado_apostado_global == 2)
                escreva("🎯 VOCÊ APOSTOU EM: EMPATE\n")
            senao
                escreva("🎯 VOCÊ APOSTOU EM: VITÓRIA ", times[time_visitante_global], "\n")
                
            escreva("💸 VALOR PERDIDO: R$ ", aposta_futebol_global, "\n")
            escreva("💳 SALDO ATUAL: R$ ", dinheiroTotal, "\n")
        }
    }
    
    
    // =========================================================================
    // ======================= FUNÇÕES AUXILIARES =============================
    // =========================================================================
    
    funcao preencheBaralho()
    {
        inteiro i = 0
        
        para (inteiro naipe = 0; naipe < 4; naipe++)
        {
            para (inteiro valor = 1; valor <= 13; valor++)
            {
                baralhoValor[i] = valor
                baralhoNaipe[i] = naipe
                i = i + 1
            }
        }
    }
    
    funcao embaralhaBaralho()
    {
        para (inteiro i = 0; i < 52; i++)
        {
            inteiro j = u.sorteia(0, 51)
            
            inteiro tempValor = baralhoValor[i]
            baralhoValor[i] = baralhoValor[j]
            baralhoValor[j] = tempValor
            
            inteiro tempNaipe = baralhoNaipe[i]
            baralhoNaipe[i] = baralhoNaipe[j]
            baralhoNaipe[j] = tempNaipe
        }
    }
    
    funcao cadeia mostrarCarta(inteiro valor, inteiro naipe)
    {
        cadeia nome = ""
        
        se (valor == 1)
            nome = "ÁS"
        senao se (valor == 11)
            nome = "VALETE"
        senao se (valor == 12)
            nome = "DAMA"
        senao se (valor == 13)
            nome = "REI"
        senao
            nome = inteiroParaTexto(valor)
            
        retorne nome + " " + naipes[naipe]
    }
    
    funcao inteiro valorCartaJogador(inteiro valor, inteiro totalAtual)
    {
        se (valor == 1)
        {
            se (totalAtual + 11 <= 21)
                retorne 11
            senao
                retorne 1
        }
        senao se (valor >= 11 e valor <= 13)
            retorne 10
        senao
            retorne valor
    }
    
    funcao inteiro valorCartaDealer(inteiro valor, inteiro totalAtual)
    {
        se (valor == 1)
        {
            se (totalAtual + 11 <= 21)
                retorne 11
            senao
                retorne 1
        }
        senao se (valor >= 11 e valor <= 13)
            retorne 10
        senao
            retorne valor
    }
    
    funcao cadeia inteiroParaTexto(inteiro numero)
    {
        se (numero == 0) retorne "0"
        se (numero == 1) retorne "1"
        se (numero == 2) retorne "2"
        se (numero == 3) retorne "3"
        se (numero == 4) retorne "4"
        se (numero == 5) retorne "5"
        se (numero == 6) retorne "6"
        se (numero == 7) retorne "7"
        se (numero == 8) retorne "8"
        se (numero == 9) retorne "9"
        se (numero == 10) retorne "10"
        retorne "?"
    }
    
    funcao cadeia repetir_char(caracter ch, inteiro vezes)
    {
        cadeia resultado = ""
        
        para(inteiro i = 0; i < vezes; i++) {
            resultado = resultado + ch
        }
        
        retorne resultado
    }
}