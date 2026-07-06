# ModernUI

> Biblioteca de interface gráfica moderna para Delphi e Lazarus/FPC.

---

# Objetivo

Criar uma biblioteca de componentes e janelas modernas, reutilizável em qualquer projeto Delphi ou Lazarus, sem dependências de terceiros e com visual inspirado em aplicações atuais.

## Princípios

- Compatível com Delphi e Lazarus/FPC
- Sem dependências externas
- Código limpo e organizado
- Fácil manutenção
- API simples
- Alto desempenho
- Compatível com High DPI
- Fácil personalização
- Separação entre lógica e interface

---

# Estrutura do Projeto

```
ModernUI
│
├── README.md
├── CHANGELOG.md
├── LICENSE
│
├── Source
│   │
│   ├── Core
│   │   ├── UI.Core.pas
│   │   ├── UI.Types.pas
│   │   ├── UI.Colors.pas
│   │   ├── UI.Constants.pas
│   │   └── UI.Utils.pas
│   │
│   ├── Graphics
│   │   ├── UI.Graphics.pas
│   │   ├── UI.Drawing.pas
│   │   ├── UI.Icons.pas
│   │   └── UI.Animation.pas
│   │
│   ├── Controls
│   │   ├── UI.Button.pas
│   │   ├── UI.Label.pas
│   │   ├── UI.Badge.pas
│   │   ├── UI.Panel.pas
│   │   └── UI.Card.pas
│   │
│   ├── Dialogs
│   │   ├── UI.Message.pas
│   │   ├── UI.Message.Form.pas
│   │   ├── UI.InputBox.pas
│   │   ├── UI.Progress.pas
│   │   └── UI.Loading.pas
│   │
│   ├── Notifications
│   │   └── UI.Toast.pas
│   │
│   └── Themes
│       ├── UI.Theme.Light.pas
│       ├── UI.Theme.Dark.pas
│       └── UI.Theme.Custom.pas
│
├── Demo
│   │
│   ├── Delphi
│   │   └── ModernUIDemo.dproj
│   │
│   └── Lazarus
│       └── ModernUIDemo.lpi
│
├── Docs
│   ├── Components.md
│   ├── Colors.md
│   ├── Themes.md
│   └── API.md
│
└── Assets
    ├── Icons
    ├── Images
    └── Fonts
```

---

# Roadmap

## Etapa 1 - Fundação

### Estrutura

- [ ] Criar estrutura de pastas
- [ ] Criar projeto Demo Delphi
- [ ] Criar projeto Demo Lazarus
- [ ] Criar paleta de cores
- [ ] Criar tipos básicos
- [ ] Criar helpers
- [ ] Criar biblioteca gráfica

---

## Etapa 1.1 - Message Dialog

### Janela

- [ ] Form sem borda
- [ ] Cantos arredondados
- [ ] Centralização automática
- [ ] Fundo branco
- [ ] Cabeçalho colorido
- [ ] Sombra
- [ ] High DPI

### Ícones

- [ ] Primary
- [ ] Secondary
- [ ] Success
- [ ] Warning
- [ ] Danger
- [ ] Info

### Botões

- [ ] OK
- [ ] Cancelar
- [ ] Sim
- [ ] Não

### API

- [ ] Criar TUIMessageType
- [ ] Criar TUIButtons
- [ ] Criar TUIResult

- [ ] Implementar

```delphi
function Message(
    const ATitulo : String;
    const ATexto  : String;
    ATipo         : TUIMessageType = mtPrimary;
    ABotoes       : TUIButtons = mbOK;
    AAutoCloseMS  : Integer = 0
): TUIResult;
```

---

## Etapa 1.2 - Aparência

- [ ] Botões arredondados
- [ ] Hover
- [ ] Pressionado
- [ ] AutoSize
- [ ] Layout automático
- [ ] Separadores
- [ ] Ajuste automático da altura
- [ ] Ajuste automático da largura

---

## Etapa 1.3 - Recursos

- [ ] Fade In
- [ ] Fade Out
- [ ] ESC fecha
- [ ] ENTER confirma
- [ ] Auto Close
- [ ] Timer

---

## Etapa 2 - Toast

- [ ] Slide
- [ ] Fade
- [ ] Auto Close
- [ ] Empilhamento
- [ ] Posições configuráveis
- [ ] Clique para fechar

---

## Etapa 3 - Componentes

### Botões

- [ ] Button

### Texto

- [ ] Label

### Containers

- [ ] Panel
- [ ] Card

### Indicadores

- [ ] Badge

### Entrada

- [ ] InputBox

### Progresso

- [ ] Progress
- [ ] Loading

---

## Etapa 4 - Temas

### Light

- [ ] Implementar

### Dark

- [ ] Implementar

### Personalizado

- [ ] Paleta customizada

---

## Compatibilidade

### Delphi

- [ ] XE
- [ ] XE2
- [ ] XE7
- [ ] 10 Seattle
- [ ] 10.4 Sydney
- [ ] 11 Alexandria
- [ ] 12 Athens

### Lazarus

- [ ] 2.x
- [ ] 3.x
- [ ] 4.x

---

# Padrões de Desenvolvimento

## Convenções

- Todas as units iniciam com `UI.`
- Classes iniciam com `TUI`
- Interfaces iniciam com `IUI`
- Helpers iniciam com `UI`
- Nenhuma unit pode depender da aplicação final.

## Filosofia

Sempre que possível:

- Utilizar apenas APIs nativas.
- Evitar componentes de terceiros.
- Priorizar desempenho.
- Manter compatibilidade Delphi/Lazarus.
- Separar desenho, lógica e interface.
- Escrever código reutilizável.

---

# Histórico

## v0.1

- Criação da estrutura do projeto.
- Definição da arquitetura.
- Início da implementação do Message Dialog.
