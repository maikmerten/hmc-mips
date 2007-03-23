#
# Test for the cache team - just loads and stores
#

	.text
start:
	addi	$8, $0, 10
	addi	$9, $0, 128
	addi	$10, $0, 0
	sw	$8, 0($9) 
	lw	$10, 0($9)
good:	sw	$9, 0x42($0)
done:	j	done	
