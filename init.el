(require 'package)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; 日本語環境の設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8)

;; org
;; http://www.mhatta.org/wp/2018/08/16/org-mode-101-1/
(setq org-directory "~/Dropbox/Org")
(setq org-default-notes-file "notes.org")
					; Org-captureの設定
					; Org-captureを呼び出すキーシーケンス
(define-key global-map "\C-cc" 'org-capture)
					; Org-captureのテンプレート（メニュー）の設定
(setq org-capture-templates
      '(("n" "Note" entry (file+headline "~/Dropbox/Org/notes.org" "Notes") "* %?\nEntered on %U\n %i\n %a")
	))


					; メモをC-M-^一発で見るための設定
					; https://qiita.com/takaxp/items/0b717ad1d0488b74429d から拝借
(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
	(switch-to-buffer buffer)
	(message "%s" file))
    (find-file (concat "~/ownCloud/Org/" file))))
(global-set-key (kbd "C-M-^")
		'(lambda ()
		   (interactive)
		   (show-org-buffer "notes.org")))


(global-hl-line-mode)

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

(add-hook 'po-mode-hook
  (quote
   (lambda ()
     (require 'texinfo)
     (font-lock-add-keywords
      'po-mode
      texinfo-font-lock-keywords))))

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
(global-set-key (kbd "C-c C-SPC")
		(quote
		 (lambda ()
		   (interactive)
		   (forward-whitespace 1)
		   (backward-char))))

(global-set-key (kbd "C-c C-f")
		(quote
		 (lambda ()
		   (interactive)
		   (forward-sexp 2))))

(setq magit-repository-directories
      '(("~/gitroot/ayatakesi.github.io" . 1)
	("~/gitroot/check-upstream-modifications" . 1)
	("~/gitroot/emacs-24.5-doc-lispref" . 1)
	("~/gitroot/emacs-25.1-doc-emacs" . 1)
	("~/gitroot/emacs-25.2-doc-emacs" . 1)
	("~/gitroot/emacs-26-doc-lispref" . 1)
	("~/gitroot/emacs-26.1-doc-emacs" . 1)
	("~/gitroot/emacs-26.1.90" . 1)
	("~/gitroot/po4a" . 1)
	("~/gitroot/termux-packages" . 1)
	("~/storage/external-1/gitroot/emacs/" . 1)))

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
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(package-selected-packages
   (quote
    (minimap htmlize google-translate pdf-tools pandoc package-utils elfeed link connection dictionary magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
