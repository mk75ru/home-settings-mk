;;; rdict.el -- Interface to rus<->eng online dictionary
;;
;; Copyright (C) 2003 Zajcev Evgeny
;;
;; Author: Zajcev Evgeny <zevlg@yandex.ru>
;; Maintainer: none, if you want be a maintainer please e-mail me
;; Keywords: dictionary, hypermedia
;; Version: 0.2
;; Date: <21 Mar 2003>
;; X-URL: http://lgarc.narod.ru/xemacs-tips/index.html
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;
;;; Commentary:
;; 
;; This is interface to the online rus<->eng dictionary lingvo.
;;
;; It requires w3 (the Emacs web browser) and russian packages to be
;; installed.
;;
;; To install rdict add following to your .emacs:
;;
;;   (autoload 'rdict "rdict"
;;             "Lookup words in the online rus<->eng dictionary" t)
;;
;; Also you may need to customize some rdict variables to make it work
;; properly:
;;
;; `rdict-prefix-pics' - (string) where pixmaps for TRANSCRIPTION
;; lays.
;;
;; `rdict-history-length' - (int) maximum length of rdict history.
;;
;; `rdict-mode-hoook' - you may add your own hooks, it will runs after
;; rdict processing.
;;
;;; TODO
;;
;; * History transcription -- Done.
;; * Movements enhancement.
;;
;;; Code

(require 'w3)
;;(require 'russian)

(defgroup rdict nil
  "Interface to the lingvo rus <-> eng dictionary"
  :prefix "rdict-"
  :group 'applications)

(defgroup rdict-faces nil
  "Faces for rdict"
  :prefix "rdict-"
  :group 'rdict
  :group 'faces)

(defface rdict-gray-face
  (` ((((class grayscale) (background light))
       (:background "Gray90"))
      (((class grayscale) (background dark))
       (:foreground "Gray80"))
      (((class color) (background light)) 
       (:foreground "dimgray"))
      (((class color) (background dark)) 
       (:foreground "gray"))
      (t (:bold t :underline t))))
  "Face for gray text."
  :group 'rdict-faces)

(defface rdict-abbrev-face
  (` ((((class grayscale) (background light))
       (:background "Gray90" :italic t))
      (((class grayscale) (background dark))
       (:foreground "Gray80" :italic t))
      (((class color) (background light)) 
       (:foreground "brown" :italic t))
      (((class color) (background dark)) 
       (:foreground "brown4" :italic t))
      (t (:bold t :underline t))))
  "Font lock faces used to highlight abbrevs"
  :group 'rdict-faces)

(defface rdict-link-face
  (` ((((class grayscale) (background light))
       (:background "Gray90" :italic t :underline t))
      (((class grayscale) (background dark))
       (:foreground "Gray80" :italic t :underline t :bold t))
      (((class color) (background light)) 
       (:foreground "blue"))
      (((class color) (background dark)) 
       (:foreground "cyan" :bold t))
      (t (:bold t :underline t))))
  "Font lock face used to highlight links to other words"
  :group 'rdict-faces)

(defvar rdict-mode-hook nil
  "*Hook to run before entering rdict-mode.")

(defvar rdict-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q")   #'rdict-restore-windows)
    (define-key map (kbd "n")   #'rdict-next)
    (define-key map (kbd "p")   #'rdict-prev)
    (define-key map (kbd "j")   #'rdict-hist-next)
    (define-key map (kbd "k")   #'rdict-hist-prev)
    (define-key map (kbd "SPC") #'scroll-up)
    (define-key map (kbd "DEL") #'scroll-down)
    (define-key map (kbd "<")   #'beginning-of-buffer)
    (define-key map (kbd ">")   #'end-of-buffer)
    (define-key map (kbd "s")   #'isearch-forward)
    (define-key map (kbd "r")   #'isearch-backward)
    (define-key map (kbd "h")   #'describe-mode)
    (define-key map (kbd "TAB") #'rdict-next-link)
    (define-key map (kbd "RET") #'rdict-follow-link)
    (define-key map (kbd "w")   #'rdict)
    map)
  "Keymap used in RDICT mode.")

(defvar rdict-history-length 10
  "Maximum words to remember")

(defvar rdict-history nil
  "List of previous searches")

(defvar rdict-hist-point 0 "Nth element in `rdict-hist' we currently active.")

(defvar rdict-saved-window-condition nil)

(defvar rdict-prefix-pics "~/.xemacs/lisp/rdict/pics"
  "*Where to look up pics files")


(defun rdict (word)
  "Lookup word in Lingvo Online Dictionary"

  (interactive (list (read-string "Translate word: " (current-word t))))
;;  (rdict-do-url (concat "lingvo.pl?text=" (rdict-win2koi word)))
)

(defun rdict-do-url (url)
  "Fetch and view URL"
  (let ((view-read-only nil))
    (unless (eq major-mode 'rdict-mode)
      (setq rdict-saved-window-condition (current-window-configuration)))

    (pop-to-buffer "*RDict*")
    (setq buffer-read-only nil)
    (erase-buffer)

    (rdict-fetch-url url)
    (rdict-proc-output url)

    (when (> (length rdict-history) rdict-history-length)
      (setq rdict-history (butlast rdict-history)))
    (push (buffer-string) rdict-history)
    (setq rdict-hist-point 0)

    (rdict-mode)))

;; XXX
(defun rdict-fetch-url (url)
  (url-insert-file-contents
   (replace-in-string
    (concat "http://lingvo.yandex.ru/cgi-bin/" url)
    ";" "%3B")))

;; XXX
(defun rdict-proc-output (word)
  "Prepare buffer for viewing"
  (goto-char (point-min))
  (let ((found nil))

    (save-excursion
      (when (re-search-forward "<hr noshade size=1>" nil t)
	(forward-line 1)
	(delete-region (point-min) (point))

	(when (re-search-forward "<hr noshade size=1>" nil t)
	  (delete-region (match-beginning 0) (point-max)))
	(setq found t)))

    (if found
	(progn
	  (save-excursion
	    (while (re-search-forward "\\|\n" nil t)
	      (replace-match "" nil nil)))

	  ;; &nbsp; -> ' '
	  (save-excursion
	    (while (re-search-forward "&[nN][bB][sS][pP];" nil t)
	      (replace-match " " nil nil)))

	  ;; margin
	  (save-excursion
	    (while (re-search-forward
		    "<[pP] [cC][lL][aA][sS][sS]=[lL]\\([0-9]\\)>" nil t)
	      (let* ((marg (string-to-int (match-string 1)))
		     (margstr (make-string marg ?\ )))
		(replace-match (concat "\n" margstr) nil nil)
	  
		(let ((cpn (point))
		      (enp)
		      (bestr))
		  (when (re-search-forward "</[pP]>" nil t)
		    (replace-match "\n" nil nil)
		    (setq enp (point))
		    (setq bestr (replace-in-string 
				 (buffer-substring cpn enp)
				 "<[bB][rR]>" (concat "\n" margstr)))
		    (delete-region cpn enp)
		    (insert bestr))))))

	  ;; <br> -> '\n'
	  (save-excursion
	    (while (re-search-forward "<[bB][rR]>" nil t)
	      (replace-match "\n" nil nil)))

	  ;; <p> -> '\n\n'
	  (save-excursion
	    (while (re-search-forward "<[pP]>" nil t)
	      (replace-match "\n\n" nil nil)))

	  (save-excursion
	    (while (re-search-forward
		    "<[sS][pP][aA][nN][ \t]*[lL][aA][nN][gG]=en-us>" nil t)
	      (replace-match "" nil nil)
	      (re-search-forward "</[sS][pP][aA][nN]>" nil t)
	      (replace-match "" nil nil)))

	  ;; gray
	  (save-excursion
	    (while (re-search-forward
		    "<[sS][pP][aA][nN] [sS][tT][yY][lL][eE]=\"color:gray\">" nil t)
	      (replace-match "" nil nil)
	      (let ((cpont (point)))
		(re-search-forward "</[sS][pP][aA][nN]>" nil t)
		(replace-match "" nil nil)
		(rdict-ins-faces cpont (point) '(rdict-gray-face)))))

	  ;; brown
	  (save-excursion
	    (while (re-search-forward
		    "<[sS][pP][aA][nN] [sS][tT][yY][lL][eE]=\"color:brown\">" nil t)
	      (replace-match "" nil nil)
	      (let ((cpont (point)))
		(re-search-forward "</[sS][pP][aA][nN]>" nil t)
		(replace-match "" nil nil)
		(rdict-ins-faces cpont (point) '(rdict-abbrev-face)))))

	  ;; <I> italic
	  (save-excursion
	    (while (re-search-forward "<[iI]>" nil t)
	      (replace-match "" nil nil)
	      (let ((cpont (point)))
		(re-search-forward "</[iI]>" nil t)
		(replace-match "" nil nil)
		(rdict-ins-faces cpont (point) '(italic)))))


	  ;; <B> bold
	  (save-excursion
	    (while (re-search-forward "<[bB]>" nil t)
	      (replace-match "" nil nil)

	      ;; for stupid fill-region :)
	      (let ((substr (substring (current-word t) 0 1)))
		(cond ((string-match "[IVXLM]" substr) (insert "\n"))
		      ((string-match "[0-9]" substr) (insert "\n"))
		      (t nil)))

	      (let ((cpont (point)))
		(re-search-forward "</[bB]>" nil t)
		(replace-match "" nil nil)
		(rdict-ins-faces cpont (point) '(bold)))))

	  ;; <a href=" -> insert rdict-url prop
	  (save-excursion
	    (while (re-search-forward "<a href=\"\\([^<>]*\\)\">" nil t)
	      (let ((url-str (match-string 1))
		    cpont)

		(replace-match "" nil nil)
		(setq cpont (point))

		(re-search-forward "</[aA]>" nil t)
		(replace-match "" nil nil)

		;; XXX
		(when url-str
		  (when (string= (substring url-str 0 9) "/cgi-bin/")
		    (setq url-str (substring url-str 9 (length url-str)))))

		(rdict-add-url-link cpont (point) url-str)
		(rdict-ins-faces cpont (point) '(rdict-link-face)))))

	  ;; <DIV .. > -> \n
	  (save-excursion
	    (while (re-search-forward "<[Dd][Ii][Vv][^<>]*>" nil t)
	      (replace-match "\n" nil nil)))

	  ;; remove not img tags
	  (save-excursion
	    (while (re-search-forward "<[/]?[^Ii][^Mm]?[^Gg]?[^<>]*>" nil t)
	      (replace-match "" nil nil)))

	  ;; remove empty lines
	  (save-excursion
	    (let ((nd t))
	      (while nd
		(if (eq (char-before (1+ (point))) ?\n)
		    (kill-line)
		  (setq nd nil)))))

	  ;; XXX
	  (save-excursion
	    (while (re-search-forward "" nil t)
	      (replace-match "" nil nil)))

	  ;; \227 -> --
	  (save-excursion
	    (while (search-forward "\227" nil t)
	      (replace-match "--" nil nil)))

	  ;; \225 -> *
	  (save-excursion
	    (while (search-forward "\225" nil t)
	      (replace-match "*" nil nil)))

	  ;; finally fill buffer
	  (save-excursion
	    (fill-region (point-min) (point-max)))

	  ;; TRANSCRIPTION
	  (save-excursion
	    (let ((nlist nil)
		  (mbeg nil))

	      ;; XXX
	      (while (re-search-forward "<[^>]*\\(src=\"/t/93.gif\">\\)\\|<[^<>]*/t/\\([0-9]*\\).gif\">" nil t)
		(let* ((ma1 (match-string 1))
		       (manum (match-string 2))
		       prop)
		  (if ma1		; transctiption
		      (save-excursion
			(delete-region mbeg (match-end 1))
			(setq mbeg nil)
;			(rdict-show-trans (cons (point) (nreverse (cons 93 nlist))))
			;;update trans property
			(setq prop (cons (list (point) (nreverse (cons 93 nlist)))
					 (get-text-property (point-min)
							    'trans)))
			
			(put-text-property (point-min) (1+ (point-min)) 'trans prop)
			(setq nlist nil))

		    (progn
		      (if (null mbeg) (setq mbeg (match-beginning 0)))
		      (setq nlist (cons (string-to-int manum) nlist))))))
	      ))

	  (rdict-show-transcription)
	  ;; remove other tags
;	  (save-excursion
;	    (while (re-search-forward "<[^<>]*>" nil t)
;	      (replace-match "" nil nil)))

	  ;; win1251 -> koi8
;;	  (russian-translate-region (point-min) (point-max) t "win-cp1251" "8koi")

	  )

      ;; Not found
      (progn 
	nil))
    ))

(defun rdict-mode ()
  "Major mode for browsing LINGVO output.
\\{rdict-mode-map}"
  (interactive)
  (use-local-map rdict-mode-map)
  (setq major-mode 'rdict-mode
	mode-name "Rdict"
	buffer-read-only t)
  (set-buffer-modified-p nil)
  ;;
  (run-hooks 'rdict-mode-hook))


(defun rdict-restore-windows ()
  (interactive)
  (when rdict-saved-window-condition
    (set-window-configuration rdict-saved-window-condition)))
;    (setq rdict-saved-window-condition

(defun rdict-ins-with-faces (string face-list)
  "Return string with inserting extent faces with face-list"
  (let ((ext (make-extent 0 (length string) string)))

    (set-extent-property ext 'duplicable t)
    (set-extent-property ext 'unique t)
    (set-extent-property ext 'start-open t)
    (set-extent-property ext 'end-open t)
    (set-extent-property ext 'face face-list))
  string)

(defun rdict-ins-faces (from to face-list)
  "Add face properties of text from FROM to TO"
  (let ((bstr (buffer-string from to)))
    (save-excursion
      (goto-char from)
      (delete-region from to)
      (insert (rdict-ins-with-faces bstr face-list)))))

(defun rdict-add-url-link (from to url)
  "Add URL property to text"
  (add-text-properties from to (list 'rdict-url url)))

(defun rdict-get-url ()
  "Gets rdict-url prop at point"
  (get-text-property (point) 'rdict-url))

(defun rdict-show-tr (number pnt)
  "Insert pixmap"
  (let ((img
	 (make-glyph
	  (expand-file-name
	   (concat rdict-prefix-pics (format "/%d.xpm" number))))))
    (set-extent-begin-glyph
     (make-extent pnt pnt) img)))

(defun rdict-show-trans (nlist)
  "Insert transcription, if NL is gevent do not take text props."
  (let* ((nl nlist)
	 (cpoi (car nl))
	 (ctr (cdr nl)))

    (while ctr
      (rdict-show-tr (car ctr) cpoi)
      (setq ctr (cdr ctr)))
    ))

(defun rdict-show-transcription ()
  "Insert transcription."
  (let ((nl (get-text-property (point-min) 'trans))
	 cpoi ctr)

    (while nl
      (setq cpoi (car (car nl)))
      (setq ctr (car (cdr (car nl))))

      (while ctr
	(rdict-show-tr (car ctr) cpoi)
	(setq ctr (cdr ctr)))
      (setq nl (cdr nl))
    )))

(defun rdict-follow-link (url)
  "Goto link"
  (interactive
   (let ((furl (rdict-get-url)))
     (list furl)))

  (when url
    (rdict-do-url url)))

(defun rdict-next-link (&optional n)
  "Jump to next link"
  (interactive "p")

  (let* ((nd t)
	 (furl (rdict-get-url))
	 (url furl)
	 (pnt))

    (save-excursion
      (while (and nd (> n 0) (not (eobp)))
	(forward-char 1)
	(setq url (rdict-get-url))
	(when (and (not (null url)) (not (eq url furl)))
	  (progn
	    (setq pnt (point))
	    (setq nd nil)))))

    (when (null nd)
      (goto-char pnt)
      (message (format "Link: -> \"%s\"" url)))))

;; If this is called we should be already
;; in the *dict* buffer.
(defun rdict-last (direction &optional n)
  "Novigate history.
DIRECTION is t if going previous item."
  (interactive)

  (setq n (% n (length rdict-history)))

  ;; Calculate position
  ;; X: 0, 1, 2,...,n		;dir = nil
  ;; Y: n, n-1, n-2,...0	;dir = t
  ;;
  ;; X->Y == Y->X: n-(x|y) where n == length of list minus 1
  (when direction			; X -> Y
    (setq rdict-hist-point (- (length rdict-history) 1 rdict-hist-point)))

  (setq rdict-hist-point (% (+ n rdict-hist-point) (length rdict-history))) ;offset

  (when direction			; back Y -> X
    (setq rdict-hist-point (- (length rdict-history) 1 rdict-hist-point)))

  (when (= (length rdict-history) 1)
    (error "This is the first Dict definition you looked at"))

  (setq buffer-read-only nil)
  (erase-buffer)
  (insert (nth rdict-hist-point rdict-history))
  (rdict-show-transcription)
  (goto-char (point-min))
  (rdict-mode))

(defun rdict-hist-prev (&optional n)
  "Goto N previous word in history."
  (interactive "p")
  (rdict-last t n)
  )

(defun rdict-hist-next (&optional n)
  "Goto N next word in history."
  (interactive "p")
  (rdict-last nil n)
  )

;; XXX
(defun rdict-next ()
  "Goto next Item"
  (interactive)
  (let ((pnt nil))
    (save-excursion
      (forward-char 1)
      (when (re-search-forward "[0-9]+\\. " nil t)
	(setq pnt (match-beginning 0))))

    (when pnt
      (goto-char pnt))))

;; XXX
(defun rdict-prev ()
  "Goto next Item"
  (interactive)
  (let ((pnt nil))
    (save-excursion
      (backward-char 1)
      (when (re-search-backward "[0-9]+\\. " nil t)
	(setq pnt (match-beginning 0))))

    (when pnt
      (goto-char pnt))))

(provide 'rdict)

;;; rdict.el ends here
