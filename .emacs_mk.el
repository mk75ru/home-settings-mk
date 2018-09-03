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
(setq compile-command "clang++ -Wall -Wextra -std=c++14 ")



;; Режим по умолчанию c переносом строк по ширине 80
;;(setq default-major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;org
;;(add-hook 'org-mode-hook  'turn-on-auto-fill)
;;(add-hook 'org-mode-hook  'toggle-truncate-lines)

;;(setq auto-fill-mode t)
;;(setq set-fill-column 20)


;; Загрузка пакетов
(load-file "~//.emacs.d/local/packages.el")



;;w3
;;(use-package w3
;;  :ensure t
;;)
(use-package w3m
  :ensure t
  :init
   (setq browse-url-browser-function 'w3m-browse-url)
   (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
   ;; optional keyboard short-cut
   (global-set-key "\C-xm" 'browse-url-at-point))
   

(use-package dic-lookup-w3m
  :ensure t  )



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
(setq special-display-buffer-names
      '("*grep*" "*compilation*"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up code completion with company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :config
  ;; Zero delay when pressing tab
  (setq company-idle-delay 0)
  (add-hook 'after-init-hook 'global-company-mode)
  ;; remove unused backends
  (setq company-backends (delete 'company-semantic company-backends))
  (setq company-backends (delete 'company-eclim company-backends))
  (setq company-backends (delete 'company-xcode company-backends))
  (setq company-backends (delete 'company-clang company-backends))
  (setq company-backends (delete 'company-bbdb company-backends))
  (setq company-backends (delete 'company-oddmuse company-backends))
  )


;;YouCompleteMe For Emacs
(load-file "~//.emacs.d/local/YouCompleteMeForEmacs.el")

;;Ctags For Emacs
(load-file "~//.emacs.d/local/RtagsForEmacs.el")

;;yasnippet
(load-file "~//.emacs.d/local/yasnippet-package2.el")

;; bring up help for key bindings
;;(use-package which-key
;;  :ensure t 
;;  :config
;;  (which-key-mode))


;; Auto completion
;;(use-package auto-complete
;;  :ensure t
;;  :init
;;  (progn
;;    (ac-config-default)
;;    (global-auto-complete-mode t)
;;    ))


;; on the fly syntax checking
;;(use-package flycheck
;;  :ensure t
;;  :init
;;  (global-flycheck-mode t))

;; snippets and snippet expansion
;;(use-package yasnippet
;;  :ensure t
;;  :init
;;  (yas-global-mode 1))


;; tags for code navigation
;;(use-package ggtags
;;  :ensure t
;;  :config 
;;  (add-hook 'c-mode-common-hook
;;	    (lambda ()
;;	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;		(ggtags-mode 1))))
;;  )

                                                                                              
;;; А здесь EMACS хранит настройки, задаваемые через customize
(setq custom-file "~/.emacs.d/customize.el")
(load-file "~/.emacs.d/customize.el")

(provide '.emacs)
;;; .emacs ends here
