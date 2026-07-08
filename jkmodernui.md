# JKModernUI

> Biblioteca de interface moderna para Delphi com mensagens estilizadas e notificações toast.

---

# Objetivo

Desenvolver uma biblioteca visual para substituir os diálogos tradicionais da VCL por componentes com aparência moderna, API simples e uso direto em projetos Delphi.

## Objetivos

- Visual moderno
- Fácil utilização
- API simples
- Sem dependências de terceiros
- Compatível com Delphi
- Estrutura organizada para evolução futura

---

# Estrutura do Projeto

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
├── assets/icons/
├── README.md
└── jkmodernui.md
```

---

# API Pública

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

---

# Checklist

## Estrutura

- [x] Criar `JKModernUI.Message.pas`
- [x] Criar `JKModernUI.Message.Form.pas`
- [x] Criar `JKModernUI.Message.Form.dfm`
- [x] Criar `JKModernUI.Toast.pas`
- [x] Criar `JKModernUI.Toast.Form.pas`
- [x] Criar `JKModernUI.Toast.Form.dfm`
- [x] Criar `JKModernUI.Colors.pas`
- [x] Criar `JKModernUI.Icons.pas`

---

## Janela

- [x] Form sem borda (`bsNone`)
- [x] Centralizar na tela
- [x] Fundo branco
- [x] Cantos arredondados
- [ ] Sombra
- [x] Ícone da aplicação
- [ ] Suporte a High DPI

---

## Layout

- [x] Cabeçalho colorido
- [x] Título
- [x] Ícone
- [x] Texto
- [x] Área dos botões
- [x] Espaçamento automático
- [x] Ajustar largura automaticamente
- [x] Ajustar altura automaticamente
- [x] Labels sincronizados com o fundo dos botões

---

## Ícones

- [x] Primary
- [x] Success
- [x] Warning
- [x] Danger
- [x] Info

---

## Botões

- [x] OK
- [x] Cancelar
- [x] Sim
- [x] Não

---

## Funcionalidades

- [x] ESC fecha a janela
- [x] ENTER confirma
- [x] Retornar `TModernResult`
- [x] Suporte aos tipos de botões
- [x] Configurar cores conforme `TModernMessageType`
- [x] Prefixar enums com `jk_` para evitar conflito com Delphi

---

## Toasts

- [x] Criar API pública para toast
- [x] Criar form não modal para toast
- [x] Fechamento automático por timer
- [x] Cantos arredondados com transparência real
- [x] Empilhamento automático
- [x] Suporte a múltiplas posições na tela
- [x] Fundo em tom suave com borda forte no padrão Bootstrap

---

## Testes

- [ ] Testar Delphi
- [ ] Testar Lazarus/FPC

---

# Decisões do Projeto

## Nome

**JKModernUI**

## Filosofia

- Código limpo
- Componentes nativos
- Sem bibliotecas externas
- Fácil reutilização
- Separação entre API e interface
- Prefixo `JK` para padronização pessoal dos componentes
- Prefixo `jk_` nos valores de enums para evitar colisão com `Dialogs`

---

# Histórico

## v0.1

- Criação da estrutura do projeto.
- Desenvolvimento da MessageBox moderna.
- Desenvolvimento do sistema de Toast.
- Renomeação da biblioteca para `JKModernUI`.
- Ajuste da API pública com prefixo `jk_`.
