![Image](https://i.ibb.co/NxtyJ3T/immudex2.png)

# IMMutable DEbian with Xfce - SDK LiveCD

## GNU/LINUX Debian stable (bookworm)

To repozytorium zawiera pliki służące do tworzenia specjalnego obrazu płyty
dostarczającego SDK do budowania dystrybucji immudex.
Zawiera ono wiele ciekawych informacji, jednak podstawowe infomacje na temat 
tej dystrybucji znajdują się pod adresem:

[https://morketsmerke.github.io/articles/immudex/immudex.html](https://morketsmerke.github.io/articles/immudex/immudex.html)

### Tworzenie obrazu płyty SDK:
  
  ```
  $ git clone https://github.com/xf0r3m/immudex-sdk
  $ cd immudex-sdk
  $ ./immudex-build --<amd64/i386>
  ```

### Dodawanie zmian do obrazu płyty:

Aby dołączyć jakiekolwiek zmiany do obrazu płyty należy przed rozpoczęciem
procesu tworzenia obrazu płyty umieścić modyfikacje, przed poleceniem `tidy` w
pliku *versions/base.sh*.

### Minimalne wymagania:

Utworzenie obrazu płyty oraz uruchomienie maszyny wirtualnej lub fizycznego
komputera, to nie wszystko. Aby można było utworzyć obraz płyty immudex,
potrzebna jest odpowiednia ilość wolnej przestrzeni dyskowej. Obecnie wspierane
są takie systemy plików tak: EXT4 oraz systemy rodziny FAT.

  ```
  Wymagana ilość dostępnego miejsca na dysku: 10G
  ```

### Zastrzeżenia i uznanie autorstwa:

immudex is not affiliated with Debian. Debian is a registered trademark owned 
by Software in the Public Interest, Inc.
