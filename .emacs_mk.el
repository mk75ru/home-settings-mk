;; Personal settings for Emacs.

;;Перезагрузка .emacs:  M-x load-file

3;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройки
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(set-face-attribute 'default nil :height 200) ; для удаленки


;; Настройки  ycmd 
(defvar my:ycmd-server-command '("python" "/home/miha/ycmd/ycmd"))
(defvar my:ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
(defvar my:ycmd-global-config "~/.ycm_extra_conf.py")
(defvar my:ycmd-startup-timeout 30)


(setq tramp-default-method "ssh")
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

;; Раздельные темы для консоли и иксов
;;(color-theme-solarized-light)
;;(if window-system
;;    (color-theme-solarized-light) ;; С этой темой emacs будет в X11
;;  (color-theme-solarized-light)) ;; С этой темой будет, если запущен консольный emacs -nw

;;(color-theme-tango-plus )) ;; С этой темой будет, если запущен консольный emacs -nw
;;(color-theme-comidia)) ;; С этой темой будет, если запущен консольный emacs -nw
 

;;C/C++
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
(require 'google-translate)
(require 'google-translate-default-ui)
(load-file "~//.emacs.d/local/GoogleTranslate.el")

;;asterisk-dialplan
(load-file "~//.emacs.d/local/asterisk-dialplan.el")



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
;;(set-register ?n (cons 'file "/var/lib/syncthing/NotesMK/index.org")) 
(set-register ?n (cons 'file "/home/miha/cloud/cloud.files/opn.files/NotesMK/index.org")) 


;;(find-file "/var/lib/syncthing/NotesMK/index.org") 
(find-file "/home/miha/cloud/cloud.files/opn.files/NotesMK/index.org") 


(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))







;;Javascript
;;; On-demand installation of packages

(require 'cl-lib)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (versions (mapcar #'package-desc-version known)))
        (if (cl-find-if (lambda (v) (version-list-<= min-version v)) versions)
            (package-install package)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t))))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))


;;; JS

(require-package 'json-mode)
(require-package 'js2-mode)
(require-package 'ac-js2)
(require-package 'coffee-mode)

(require-package 'tern)
(require-package 'tern-auto-complete)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))




(provide '.emacs)
;;; .emacs ends here
