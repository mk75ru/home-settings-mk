;; Personal settings for Emacs.

;;Перезагрузка .emacs:  M-x load-file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройки
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройки  ycmd 
(defvar my:ycmd-server-command '("python" "/home/miha/ycmd/ycmd"))
(defvar my:ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
(defvar my:ycmd-global-config "~/.ycm_extra_conf.py")
(defvar my:ycmd-startup-timeout 30)

;;Команда компиляции для  C/C++
;;(setq compile-command "clang++ -Wall -Wextra -std=c++14 ")
;;(setq compile-command "cd /home/miha/prj/prj-kugo-bsi/alarm-kugo/build-armv7a-debug; make -j8 install")
(setq compile-command "cd /home/miha/prj/prj-kugo-bsi/alarm-kugo; ./deploy-remote.sh")

;;Инициализация менеджера пакетов
(load-file "~//.emacs.d/local/UsePackageInit.el")

;;C-mode
(load-file "~//.emacs.d/local/CcMode.el")

(use-package modern-cpp-font-lock
  :ensure t
  :config	    
    (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
    ;;or:
    ;;    (modern-c++-font-lock-global-mode t)
    )

;;Настройка внешнего вида редактора 
(load-file "~//.emacs.d/local/faceemacs.el")

;;Сохранение сеанса
(load-file "~//.emacs.d/local/savesession.el")

;;Поиск парной скобки и их подсветка A-q
(load-file "~//.emacs.d/local/matchparen.el")

;;Перемещение между окнами
;;Перемещение по окнам при помощи клавиш  <S-up>, <S-down>, <S-left>, <S-right>
(load-file "~//.emacs.d/local/window-number.el")

;;Управляем размером окна
;;изменять размеры окна, по умолчанию, можно мышкой, для этого нужно убирать руку от клавиатуры. 
;;а это удобно? я тоже так думаю. добавлем следущее в .emacs.
;;как видно из keymap' ом, 'ctrl + alt + \arrow keys\' резайзит окна. 
(load-file "~//.emacs.d/local/resize-window.el")

;; Резервные копии
(load-file "~//.emacs.d/local/backups.el")

;; Автозаполнение
;;(load-file "~//.emacs.d/local/auto-fill.el")

;; grep  и compilation в новом окне
(load-file "~//.emacs.d/local/SpecialDisplayBufferNames.el")

;; Set up code completion with company
(load-file "~//.emacs.d/local/CompanyCodeCompletion.el")

;;YouCompleteMe For Emacs
(load-file "~//.emacs.d/local/YouCompleteMeForEmacs.el")

;;Rtags For Emacs
(load-file "~//.emacs.d/local/RtagsForEmacs.el")

;;yasnippet
(load-file "~//.emacs.d/local/yasnippet-package.el")


;;Браузер
;;(load-file "~//.emacs.d/local/W3m.el")

;;Словарь
;;(load-file "~//.emacs.d/local/DicLookupW3m.el")

;;Словарь
;;(load-file "~//.emacs.d/local/Sdcv.el")

;;Словарь
(load-file "~//.emacs.d/local/GoogleTranslate.el")


;;; А здесь EMACS хранит настройки, задаваемые через customize
(setq custom-file "~/.emacs.d/customize.el")
(load-file "~/.emacs.d/customize.el")

(provide '.emacs)
;;; .emacs ends here
