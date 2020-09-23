if defined QLIC_KC (
	echo getting test.q from embedpy
        curl -fsSL -o test.q https://github.com/KxSystems/embedpy/raw/master/test.q
        q test.q precision/ -q
)
