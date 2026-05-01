# Lilidji Shot

Минималистичный скриншотер для Ubuntu/GNOME на русском языке.

Что умеет:

- `Print`: выбор области
- `Shift+Print`: весь экран
- сохранение в `~/Pictures/Screenshots`
- копирование изображения в буфер обмена
- рисование поверх скриншота: карандаш, маркер, квадрат, круг, стрелка
- выбор цвета
- скрытие курсора
- интеграция с Codex CLI: `Ctrl+Shift+V` в `gnome-terminal` вставляет картинку из буфера в чат Codex

## Ограничения

- полноценный серый интерфейс работает в `X11`
- на `Wayland` используется fallback через `flameshot`
- горячая клавиша `Ctrl+Shift+V` переназначается под вставку изображения в Codex CLI
- обычная текстовая вставка в `gnome-terminal` после настройки доступна через `Shift+Insert`

## Структура

- `scripts/lilidji-shot` — основной запускатель
- `scripts/lilidji-shot-ui` — GTK-интерфейс
- `scripts/codex-image-paste` — helper для вставки изображения в Codex CLI
- `scripts/lilidji-shot-session-setup` — настройка биндов GNOME
- `packaging/debian/build.sh` — сборка `.deb`

## Сборка пакета

```bash
cd packaging/debian
./build.sh
```

Готовый пакет появится в `packaging/debian/lilidji-shot_<version>_all.deb`.

## Установка

Ставить удобнее всего через релизный `.deb`:

```bash
sudo apt install ./lilidji-shot_1.0.3-1_all.deb
```

После установки пакет настраивает:

- `Print`
- `Shift+Print`
- `Alt+Print`
- `Ctrl+Shift+V` для Codex CLI

Если бинды не применились сразу, достаточно перелогиниться в GNOME.
