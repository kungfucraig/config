;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MATLAB Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . octave-mode))
 (setq octave-indent-function t)
