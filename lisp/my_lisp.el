(require 'po-mode)
(require 'ediff)

(defun my_ediff_previous_current_msgid ()
    (interactive)
    
    ;; current msgid
    (po-find-span-of-entry)
    (setq current_msgid (po-get-msgid))

    ;; previous msgid
    (po-find-span-of-entry)    
    (setq previous_msgid (my-po-get-previous-msgid 0))

    ;;
    (if (get-buffer "my_prev")
	(kill-buffer "my_prev"))
    (setq prev (get-buffer-create
		(generate-new-buffer-name "my_prev")))
    (set-buffer prev)
    (insert previous_msgid)

    ;;
    (if (get-buffer "my_curr")
	(kill-buffer "my_curr"))
    (setq curr (get-buffer-create
		(generate-new-buffer-name "my_curr")))
    (set-buffer curr)
    (insert current_msgid)
    
    ;;
    (split-window)
    (switch-to-buffer prev)
    (select-window (next-window))
    (switch-to-buffer curr)    
    (my-ediff-buffers-wordwise prev curr)
    )

(defun my-po-get-previous-msgid (kill-flag)
  (let ((buffer (current-buffer))
        (obsolete (eq po-entry-type 'obsolete)))
    (save-excursion
      (goto-char po-start-of-entry)
      (if (re-search-forward po-any-previous-msgid-regexp po-end-of-entry t)
          (po-with-temp-buffer
            (insert-buffer-substring buffer (match-beginning 0) (match-end 0))
            (goto-char (point-min))
            (while (not (eobp))
              (if (looking-at (if obsolete "#|\\(\n\\| \\)" "#| ?"))
                  (replace-match "" t t))
              (forward-line 1))
            (and kill-flag (copy-region-as-kill (point-min) (point-max)))
            (po-extract-unquoted (current-buffer)
                                     (point-min)
                                     (point-max)))
        ""))))


(defun my-ediff-buffers-wordwise (buff-A buff-B)
  (setq wind-A (get-buffer-window buff-A)
	wind-B (get-buffer-window buff-B))

  (select-window wind-A)
  (setq beg-A (point-min)
	end-A (point-max))
  (save-excursion
    (save-window-excursion
      (sit-for 0)
      (select-window wind-A)
      (setq beg-A (point-min)
	    end-A (point-max))
      (select-window wind-B)
      (setq beg-B (point-min)
	    end-B (point-max))))

  (setq buff-A
	(ediff-clone-buffer-for-window-comparison
	 buff-A wind-A "-Window.A-")
	buff-B
	(ediff-clone-buffer-for-window-comparison
	 buff-B wind-B "-Window.B-"))
  (ediff-regions-internal
   buff-A beg-A end-A buff-B beg-B end-B
   nil 'ediff-windows-wordwise 'word-mode nil)
  )

