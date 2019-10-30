(require 'package)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; 日本語環境の設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8)

;; delete-selection-mode
(delete-selection-mode)

;; Show/hide Emacs dired details in style
;; http://xenodium.com/showhide-emacs-dired-details-in-style/
(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :config
  ;; Colourful columns.
  (use-package diredfl
    :ensure t
    :config
    (diredfl-global-mode 1)))

;; ffap
(global-set-key (kbd "C-x C-f") 'ffap)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; anzu
(global-anzu-mode +1)

;; eldoc-box
(require 'eldoc-box)

;; helpful settings from
;; https://github.com/Wilfred/helpful/blob/0a83a7b028881a7a463ba5dfc7646ca98afc48c7/README.md

;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)

;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;; elisp-demos with helpful
;; https://github.com/xuchunyang/elisp-demos/blob/master/README.md
(advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update)


;; google-translate
(setq load-path (cons "~/.emacs.d/elpa/google-translate-0.11.16/" load-path))
(require 'google-translate)
(require 'google-translate-default-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)
;; https://qiita.com/minoruGH/items/75eb4fab53e93653f999
;; Fix error of "Failed to search TKK"
(defun google-translate--get-b-d1 ()
  ;; TKK='427110.1469889687'
  (list 427110 1469889687))


;;; gettext
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-find-file-coding-system "po-compat")
(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
			    'po-find-file-coding-system)

(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)

(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
                            'po-find-file-coding-system)

;;; hilight texinfo keywords
(add-hook 'po-mode-hook 
  (quote
   (lambda ()
     (require 'texinfo)
     (font-lock-add-keywords
      'po-mode
      texinfo-font-lock-keywords))))

;;; toggle IM at edit
(advice-add #'po-edit-msgstr :after
	    #'(lambda ()
		(toggle-input-method)
		(font-lock-add-keywords
		 nil
		 texinfo-font-lock-keywords)))

;;; recenter when po-next-entry
(advice-add #'po-next-entry :after
	    #'(lambda ()
		"recenter"
		(recenter nil)))

;;; my setting
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "my_lisp.el")

; eldoc
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode 'eldoc-mode)

; else
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-h") 'delete-backward-char)

(let ((my-next-whitespace-minus1 (lambda ()
				   (interactive)
				   (forward-whitespace 1)
				   (backward-char)))
      
      (my-forward-sexp2 (lambda ()
			  (interactive)
			  (let ((curr (point)))
			    (search-forward "@")
			    (backward-char 1)
			    (set-mark (point))
			    (forward-sexp 2)
			    (kill-region
			     (region-beginning)
			     (region-end))
			    (goto-char curr))))
      
      (my-termux-dialog (lambda ()
			  (interactive)
			  (let ((ans (shell-command-to-string "termux-dialog")))
			    (string-match "^  \"text\": \"\\(.*\\)\"$" ans)
			    (insert (match-string 1 ans))))))
  
  (global-set-key (kbd "C-c C-SPC") my-next-whitespace-minus1)
  (global-set-key (kbd "C-c C-f") my-forward-sexp2)
  (global-set-key (kbd "C-c C-z") my-termux-dialog))

;;; ddskk
(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  ;;良い感じに改行を自動入力してくれる機能
  (setq default-input-method "japanese-skk")
  ;;emacs上での日本語入力にskkをつかう
  (require 'skk-study)) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-default-directory-list (quote ("/data/data/com.termux/files/usr/share/info/")))
 '(browse-url-browser-function (quote eww-browse-url))
 '(compilation-scroll-output t)
 '(dictionary-server "localhost")
 '(elfeed-feeds
   (quote
    ("http://planet.gnu.org/rss20.xml" "http://static.fsf.org/fsforg/rss/blogs.xml" "https://static.fsf.org/fsforg/rss/news.xml" "http://sachachua.com/blog/feed/")))
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(makeinfo-options "--fill-column=56")
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (anzu auto-complete diredfl use-package elpa-clone ivy-posframe eldoc-box crux neotree ag elisp-demos helpful ddskk minimap htmlize google-translate pdf-tools pandoc package-utils elfeed link connection magit)))
 '(po-default-file-header
   "# SOME DESCRIPTIVE TITLE.
# Copyright (C) YEAR Free Software Foundation, Inc.
# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
#
#, fuzzy
msgid \"\"
msgstr \"\"
\"Project-Id-Version: PACKAGE VERSION\\n\"
\"PO-Revision-Date: YEAR-MO-DA HO:MI +ZONE\\n\"
\"Last-Translator: ayatakesi <ayanokoji.takesi@gmail.com>\\n\"
\"Language-Team: japanese\\n\"
\"MIME-Version: 1.0\\n\"
\"Content-Type: text/plain; charset=UTF-8\\n\"
\"Content-Transfer-Encoding: 8bit\\n\"
")
 '(scroll-margin 2)
 '(skk-cdb-large-jisyo nil)
 '(skk-initial-search-jisyo "~/.emacs.d/skk-get-jisyo/SKK-JISYO.L"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
