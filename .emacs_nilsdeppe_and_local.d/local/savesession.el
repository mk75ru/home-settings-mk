;; Подключение библиотеки Desktop для сохранения состояния Emacs 
;;от одного сеанса к другому.
(desktop-load-default) 
(desktop-read)
;; Переменная desktop-files-not-to-save говорит, какие файлы исключаются при со-
;;хранении состояния. 
;;Ее значение - это регулярное выражение, совпадающее с именами
;;исключаемых файлов. 
;;-----------------------------------------------------------------------------
