;; -*- lexical-binding: t -*-

(package! lsp-mode
          (hooks! lsp-mode-hook
                  (lambda ()
                    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
                    (lsp-headerline-breadcrumb-mode)
                    (tyrant-def "l" lsp-command-map)))
          (setq lsp-enable-which-key-integration t))

(package! lsp-ui
          (hooks! lsp-mode-hook #'lsp-ui-mode))

(when! ivy
       (package! lsp-ivy))
