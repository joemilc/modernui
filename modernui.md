# ModernUI

> Biblioteca de interface gráfica moderna para Delphi e Lazarus/FPC.

---

# Objetivo

Desenvolver uma MessageBox moderna para substituir o `MessageDlg` padrão da VCL/LCL.

## Objetivos

- Visual moderno
- Fácil utilização
- API simples
- Sem dependências de terceiros
- Compatível com Delphi
- Preparar o código para futura compatibilidade com Lazarus/FPC

---

# Estrutura do Projeto

```
ModernUI
│
├── ModernUI.Message.pas
├── ModernUI.Message.Form.pas
├── ModernUI.Message.Form.dfm
└── ModernUI.md
```

---

# API Pública

```delphi
type
  TModernMessageType = (
    mtPrimary,
    mtSuccess,
    mtWarning,
    mtDanger,
    mtInfo
  );

  TModernButtons = (
    mbOK,
    mbOKCancel,
    mbYesNo
  );

  TModernResult = (
    mrOK,
    mrCancel,
    mrYes,
    mrNo
  );

function MUMessage(
  const ATitulo : string;
  const ATexto  : string;
  ATipo         : TModernMessageType = mtPrimary;
  ABotoes       : TModernButtons = mbOK
): TModernResult;
```

---

# Checklist

## Estrutura

- [x] Criar `ModernUI.Message.pas`
- [x] Criar `ModernUI.Message.Form.pas`
- [x] Criar `ModernUI.Message.Form.dfm`

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

---

## Testes

- [ ] Testar Delphi
- [ ] Testar Lazarus/FPC

---

# Decisões do Projeto

## Nome

**ModernUI**

## Filosofia

- Código limpo
- Componentes nativos
- Sem bibliotecas externas
- Fácil reutilização
- Separação entre API e interface

---

# Histórico

## v0.1

- Criação da estrutura do projeto.
- Desenvolvimento da Modern MessageBox.