(defun oak/init/edit ()
  "Edit init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun oak/init/reload ()
  "Reload init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el")
  (message "init.el reloaded!"))

(defun oak/yank-current-file-path ()
  "Add to the clipboard the current file path"
  (interactive)
  (setq file-path (buffer-file-name))
  (shell-command (concat "echo " file-path " | pbcopy")))

;; https://www.emacswiki.org/emacs/KillingBuffers#toc2
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(provide 'oak-function)
