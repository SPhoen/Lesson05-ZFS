         _______  _______  _______    _        _______  _______  _______  _______  _       
        / ___   )(  ____ \(  ____ \  ( \      (  ____ \(  ____ \(  ____ \(  ___  )( (    /|
        \/   )  || (    \/| (    \/  | (      | (    \/| (    \/| (    \/| (   ) ||  \  ( |
            /   )| (__    | (_____   | |      | (__    | (_____ | (_____ | |   | ||   \ | |
           /   / |  __)   (_____  )  | |      |  __)   (_____  )(_____  )| |   | || (\ \) |
          /   /  | (            ) |  | |      | (            ) |      ) || |   | || | \   |
         /   (_/\| )      /\____) |  | (____/\| (____/\/\____) |/\____) || (___) || )  \  |
        (_______/|/       \_______)  (_______/(_______/\_______)\_______)(_______)|/    )_)
                 ______                                                                    
                (  ___ \ |\     /|                                                         
                | (   ) )( \   / )                                                         
                | (__/ /  \ (_) /                                                          
                |  __ (    \   /                                                           
                | (  \ \    ) (                                                            
                | )___) )   | |                                                            
                |/ \___/    \_/                                                            
         _______  _______           _______  _______  _       _________                  
        (  ____ \(  ____ )|\     /|(  ___  )(  ____ \( (    /|\__   __/|\     /|         
        | (    \/| (    )|| )   ( || (   ) || (    \/|  \  ( |   ) (   ( \   / )         
        | (_____ | (____)|| (___) || |   | || (__    |   \ | |   | |    \ (_) /          
        (_____  )|  _____)|  ___  || |   | ||  __)   | (\ \) |   | |     ) _ (           
              ) || (      | (   ) || |   | || (      | | \   |   | |    / ( ) \          
        /\____) || )      | )   ( || (___) || (____/\| )  \  |___) (___( /   \ )         
        \_______)|/       |/     \|(_______)(_______/|/    )_)\_______/|/     \|         
                                                                                        
                                                                                                                                                            
##       Домашнее задание по теме ZFS

       ЗАДАНИЕ: Выполнить цепочку действий и в результате получить секретное сообщение.

       Файлы репозитория:
        readme.md - вы его сейчас читаете
        Vagrantfile - описание виртуальной машины для домашнего задания
        commands - команды, используемые в домашнем задании
        stdout - лог выполнения домашнего задания.
        zfs.sh - скрипт установки пакетов для работы с ZFS

        Особенности выполнения домашнего задания
            1. Для выполнения ДЗ не каждая версия ядра. Один из рекомендуемых образов - bento/centos-8
            2. Изначально в ДЗ много ошибок, пришлось пересматривать дополнительные видеоуроки на ютубе и читать документаци.

        Ключевые особенности ДЗ
            1. Компрессия
                zfs set compression=lzjb otus1
                zfs set compression=lz4 otus2
                zfs set compression=gzip-9 otus3
                zfs set compression=zle otus4
                zfs get all |grep compressratio | grep -v ref
                otus1  compressratio         1.81x                  -
                otus2  compressratio         2.22x                  - 
                otus3  compressratio         3.64x                  -
                otus4  compressratio         1.00x                  -                

            Видно, что лучшую компрессию обеспечивает алгоритм gzip-9

            2. Секретное послание
                [root@server /]# cat /otus/test/task1/file_mess/secret_message
                https://github.com/sindresorhus/awesome



        Заметки: В итоге ссылка привела на репо с антироссийскими высказываниями владельца репо. "Ваше мнение очень важно для нас" (с)


***



                                                                                                                                                                  
                                                                                                                                                                  
                                                                                                                                                                  
                                                                                                                                                                  
                                                                                                                                                                  
                                                                                                                                                                                 