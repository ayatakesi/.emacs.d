;;; elpa-clone-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "elpa-clone" "elpa-clone.el" (0 0 0 0))
;;; Generated autoloads from elpa-clone.el

(autoload 'elpa-clone "elpa-clone" "\
Clone ELPA archive.

UPSTREAM is an ELPA URL or local ELPA directory.
DOWNSTREAM is the download directory.

By default, `elpa-clone' will choose the appropriate SYNC-METHOD for UPSTREAM.
You can also specify the method.  Available methods are:

  `rsync' -- use rsync
  `url'   -- use the \"url\" library.  See Info node `(url)'.
  `local' -- treat UPSTREAM as a local directory.
  `nil'   -- choose a method based on UPSTREAM.

Default SYNC-METHOD is `nil'.

When SIGNATURE is nil, download *.sig files only if exists.
When SIGNATURE is `never', never download *.sig files.
When SIGNATURE is any other value, always download *.sig files.

When README is nil, download readme files only if exists.
When README is `never', never download readme files.
When README is any other value, always download readme files.

\(fn UPSTREAM DOWNSTREAM &key SYNC-METHOD SIGNATURE README)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elpa-clone" '("elpa-clone-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; elpa-clone-autoloads.el ends here
