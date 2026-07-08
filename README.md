# JKModernUI

Biblioteca visual para Delphi com `MessageBox` moderna e `Toasts` estilizados, usando VCL nativa, sem dependências externas e com API simples para uso no dia a dia.

Repositório: [https://github.com/joemilc/modernui](https://github.com/joemilc/modernui)

![JKModernUI](logo.png)

## Sobre

O objetivo do `JKModernUI` é substituir as janelas visuais mais antigas do Delphi por componentes com aparência moderna, melhor experiência de uso e integração simples ao projeto.

Hoje a biblioteca oferece:

- `JKMUMessage` para caixas de mensagem modernas
- `JKMUToast` para notificações temporárias
- layout com cantos arredondados
- cores contextuais inspiradas no Bootstrap
- ícones por tipo de mensagem
- posicionamento configurável para os toasts
- arraste manual das mensagens e dos toasts

## Recursos

- Visual moderno com bordas arredondadas
- Header colorido por tipo de mensagem
- Botões `OK` e `Sim` seguindo o estilo da mensagem
- Botões `Cancelar` e `Não` sempre em vermelho
- Toasts não modais com fechamento automático
- Toasts com várias posições na tela
- Transparência correta nos cantos dos toasts
- Código organizado em API pública, cores, ícones e formulários
- Compatível com projetos Delphi VCL

## Estrutura

```text
JKModernUI
│
├── JKModernUI.Message.pas
├── JKModernUI.Message.Form.pas
├── JKModernUI.Message.Form.dfm
├── JKModernUI.Toast.pas
├── JKModernUI.Toast.Form.pas
├── JKModernUI.Toast.Form.dfm
├── JKModernUI.Colors.pas
├── JKModernUI.Icons.pas
├── assets/
│   └── icons/
├── ModernUI_Demo.dpr
├── README.md
└── youtube.md
```

## API Pública

### Tipos

```delphi
type
  TModernMessageType = (
    jk_mtPrimary,
    jk_mtSuccess,
    jk_mtWarning,
    jk_mtDanger,
    jk_mtInfo
  );

  TModernButtons = (
    jk_mbOK,
    jk_mbOKCancel,
    jk_mbYesNo
  );

  TModernResult = (
    jk_mrOK,
    jk_mrCancel,
    jk_mrYes,
    jk_mrNo
  );

  TModernToastPosition = (
    jk_tpCenter,
    jk_tpCenterTop,
    jk_tpCenterBottom,
    jk_tpLeftCenter,
    jk_tpLeftTop,
    jk_tpLeftBottom,
    jk_tpRight,
    jk_tpRightTop,
    jk_tpRightCenter,
    jk_tpRightBottom
  );
```

### Funções

```delphi
function JKMUMessage(
  const ATitulo: string;
  const ATexto: string;
  ATipo: TModernMessageType = jk_mtPrimary;
  ABotoes: TModernButtons = jk_mbOK
): TModernResult;

procedure JKMUToast(
  const ATitulo: string;
  const ATexto: string;
  ATipo: TModernMessageType = jk_mtPrimary;
  ADuracaoMs: Integer = 4000;
  APosicao: TModernToastPosition = jk_tpRightTop
);
```

## Exemplos

### MessageBox

```delphi
JKMUMessage('Aviso', 'Esta é uma mensagem primária.', jk_mtPrimary, jk_mbOK);
JKMUMessage('Sucesso', 'Operação concluída com sucesso.', jk_mtSuccess, jk_mbOK);
JKMUMessage('Aviso', 'Verifique os dados informados.', jk_mtWarning, jk_mbOK);
JKMUMessage('Erro', 'Ocorreu um erro durante a operação.', jk_mtDanger, jk_mbOK);
JKMUMessage('Informação', 'Esta é uma mensagem informativa.', jk_mtInfo, jk_mbOK);

if JKMUMessage('Confirmação', 'Deseja continuar?', jk_mtPrimary, jk_mbOKCancel) = jk_mrOK then
begin
  // confirmar
end;

case JKMUMessage('Pergunta', 'Deseja salvar as alterações?', jk_mtPrimary, jk_mbYesNo) of
  jk_mrYes:
    begin
      // salvar
    end;
  jk_mrNo:
    begin
      // ignorar
    end;
end;
```

### Toast

```delphi
JKMUToast('Primário', 'Toast padrão no canto superior direito.', jk_mtPrimary, 3500, jk_tpRightTop);
JKMUToast('Sucesso', 'Toast centralizado no topo da tela.', jk_mtSuccess, 4000, jk_tpCenter);
JKMUToast('Aviso', 'Toast no canto inferior esquerdo.', jk_mtWarning, 4500, jk_tpLeftBottom);
JKMUToast('Erro', 'Toast alinhado ao centro da direita.', jk_mtDanger, 5000, jk_tpRightCenter);
JKMUToast('Informação', 'Toast centralizado na parte inferior.', jk_mtInfo, 5500, jk_tpCenterBottom);
```

## Como Adicionar Ao Projeto

1. Copie as units `JKModernUI.*.pas` e os respectivos arquivos `.dfm`.
2. Copie a pasta `assets/icons`.
3. Adicione as units necessárias ao seu projeto Delphi.
4. Importe `JKModernUI.Message` e `JKModernUI.Toast`.
5. Use `JKMUMessage` e `JKMUToast` normalmente.

## Demo

O projeto inclui um demo funcional em `ModernUI_Demo.dpr`, com exemplos de uso em `Unit1.pas`.

Arquivos multimídia disponíveis no projeto:

- `JKModernUI.mov`
- `apresentacao.mp4`

## Compatibilidade

- Delphi VCL
- Estrutura preparada para evolução futura
- Organização que facilita adaptação posterior

## Vídeo

O arquivo com texto pronto para YouTube está em `youtube.md`.

## Resumo Rápido

> JKModernUI é uma biblioteca visual para Delphi com MessageBox moderna e Toasts estilizados, usando VCL nativa, cantos arredondados, ícones contextuais, múltiplas posições para toast e API simples. Repositório: https://github.com/joemilc/modernui

## Licença

Defina aqui a licença que deseja usar no repositório.
