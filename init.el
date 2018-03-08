
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; gettext
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)

;(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
;                            'po-find-file-coding-system)
;(autoload 'po-find-file-coding-system "po-mode")

;;; my setting
(load "~/.emacs.d/my_lisp.el")

; eldoc
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode 'eldoc-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dict-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'dictionary-search "dictionary" 
	  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
	  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary" 
	  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
	  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
	  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
	  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
	  "Display tooltips for the current word" t)
(unless (boundp 'running-xemacs)
	(autoload 'global-dictionary-tooltip-mode "dictionary"
		  "Enable/disable dictionary-tooltip-mode for all buffers" t))
;; key bindings for dictionary.el
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)

; else
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c C-SPC") 'forward-whitespace)
(global-set-key (kbd "C-c C-f")
		(quote
		 (lambda ()
		   (interactive)
		   (if
		       (search-forward
			(char-to-string
			 (char-after)) nil nil 2)
		       (backward-char)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote eww-browse-url))
 '(dictionary-server "localhost")
 '(elfeed-feeds
   (quote
    ("http://planet.gnu.org/rss20.xml" "http://static.fsf.org/fsforg/rss/blogs.xml" "https://static.fsf.org/fsforg/rss/news.xml" "http://sachachua.com/blog/feed/")))
 '(package-selected-packages
   (quote
    (pandoc package-utils elfeed link connection dictionary magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
