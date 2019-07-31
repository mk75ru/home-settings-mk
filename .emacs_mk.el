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


(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;;Команда компиляции для  C/C++
;;(setq compile-command "clang++ -Wall -Wextra -std=c++14 ")

(setq compile-command "make -j8 install")


(setq prj-grep-find-command '(" 
find . \
-name 'alarm-kugo.src*' \
-prune -o \
-type d \
 \\( \
-path ./build-armv7a-debug -o \
-path ./build-armv7a-doxy-debug -o \
-path ./.git  -o \
-path ./build-x86-debug -o \
-path ./.idea  -o \
-path ./files -o \
-path ./firmware -o \
-path  data.bak  \
 \\)  \
-prune -o  -type f -exec grep -nH -e  \\{\\} +
" . 279 ))

;;;###autoload
(defun prj-grep-find (command-args)
  "Run grep via find, with user-specified args COMMAND-ARGS.
Collect output in a buffer.
While find runs asynchronously, you can use the \\[next-error] command
to find the text that grep hits refer to.

This command uses a special history list for its arguments, so you can
easily repeat a find command."
  (interactive
   (progn
     (grep-compute-defaults)
     (if prj-grep-find-command
	 (list (read-shell-command "Run find (like this): "
                                   prj-grep-find-command 'grep-find-history))
       ;; No default was set
       (read-string
        "compile.el: No `grep-find-command' command available. Press RET.")
       (list nil))))
  (when command-args
    (let ((null-device nil))		; see grep
      (grep command-args))))

;;;###autoload
(defalias 'prj-find-grep 'prj-grep-find)


;;Инициализация менеджера пакетов
(load-file "~//.emacs.d/local/UsePackageInit.el")

;;C-mode
(load-file "~//.emacs.d/local/CcMode.el")


(use-package modern-cpp-font-lock
  :ensure t
  :init
  (eval-when-compile
      ;; Silence missing function warnings
    (declare-function modern-c++-font-lock-global-mode
                      "modern-cpp-font-lock.el"))
  :config
  (modern-c++-font-lock-global-mode t)
  )

;;(use-package modern-cpp-font-lock
;;  :ensure t
;;  :config	    
;;  (
;;   add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
;;  ;;or:
;;  ;; (modern-c++-font-lock-global-mode t)
;;  )

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
(load-file "~//.emacs.d/local/Sdcv.el")

;;Словарь
(load-file "~//.emacs.d/local/GoogleTranslate.el")


;;; А здесь EMACS хранит настройки, задаваемые через customize
(setq custom-file "~/.emacs.d/customize.el")
(load-file "~/.emacs.d/customize.el")



;;(require 'org-protocol)
;;(load-file "~/.emacs.d/org-protocol-capture-html.el")
;;(require 'org-protocol-capture-html)

;;(add-to-list 'org-capture-templates
;;             ("w" "Web site" entry (file "~/org/notes.org")
;;              "* %?\n%c\n%:initial"))

(server-start)
(require 'org-protocol)
;;(setq org-todo-keywords
;;       '((sequence "TODO(t)" "IN PROGRESS(p!)" "|" "DONE(d!)" "CANCELLED(c!)")))

;;(setq org-log-done 'time)

;;(setq org-capture-templates
;;      (quote (
;;	      ("t" "todo" entry (file "~/org/refile.org")
;;               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;	      )))



 (setq org-capture-templates
       '(
	 ("p" "Web site" entry (file+headline (lambda () (concat org-directory "~/org")) "Inbox")
	  "* %a\nCaptured On: %U\nWebsite: %l\n\n%i\n%?")

	 ("m" "meetup" entry (file "~/org/bookmarks.org") "* %?%:description \n%i\n%l")
	 
	 ))


;; (setq org-capture-templates
;;       '("w" "Capture from web browser such as Conkeror" entry
;;         (file+headline "~/org/bookmarks.org" "Web capture")
;;         "* %c %?
;;  Sourced: %u
;;  %i" :prepend t :jump-to-captured t))

(global-set-key (kbd "C-c c") 'org-capture)

;;Заметки  C-x rjn
(set-register ?n (cons 'file "/var/lib/syncthing/NotesMK/index.org")) 

(find-file "/var/lib/syncthing/NotesMK/index.org") 


(provide '.emacs)
;;; .emacs ends here
