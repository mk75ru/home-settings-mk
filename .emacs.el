;; Personal settings for Emacs.

;;Перезагрузка .emacs:  M-x load-file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration/Customization:
;; Defines global variables that are later used to customize and set
;; up packages.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Specify the ycmd server command and path to the ycmd directory *inside* the
;; cloned ycmd directory
(defvar my:ycmd-server-command '("python" "/home/mikhail/ycmd/ycmd"))

(defvar my:ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
(defvar my:ycmd-global-config "~/.ycm_extra_conf.py")
(defvar my:ycmd-startup-timeout 3)



	
	
	
	

;; Compilation command for C/C++
(defvar my:compile-command "clang++ -Wall -Wextra -std=c++14 ")

;; Emacs is not a package manager, and here we load its package manager!  
(load-file "~//.emacs.d/local/package.el")

;;YouCompleteMeForEmacs
(load-file "~//.emacs.d/local/YouCompleteMeForEmacs.el")


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
(load-file "~//.emacs.d/local/auto-fill.el")



;; grep  и compilation в новом окне
(setq special-display-buffer-names
      '("*grep*" "*compilation*"))


                                 
                                                                                          
(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:update-interval 5)
 '(package-selected-packages
   (quote
    ( company-ycmd company-jedi))))

