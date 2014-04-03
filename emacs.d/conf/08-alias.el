;;;;;;;;;;;;;;;;;;
;;; alias設定集 ;;;
;;;;;;;;;;;;;;;;;;

;; 行末の空白行を消去する
(defalias 'dtw 'delete-trailing-whitespace)

;; ;; ドキュメントの串刺し検索
;; (defalias 'afd 'anything-for-document)

;; 選択範囲に対してPerlコマンドを実行する関数
(defalias 'pev 'perl-eval)

;; ソースコード上でプログラムの実行を行う関数
(defalias 'qr 'quickrun-sc)