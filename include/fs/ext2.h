/*
+-----------------------+
| Superblock            |
+-----------------------+
| Inode Bitmap          |
+-----------------------+
| Data Block Bitmap     |
+-----------------------+
| Inode Table           |
+-----------------------+
| Data Blocks           |
|                       |
|   Used       Free     |
|   Blocks     Blocks   |
+-----------------------+
*/

struct ext2_inode {
	uint        i_data[15];
	uint        i_flags;
	uint        i_faddr;
	uchar       i_frag;
	uchar       i_fsize;
	ushort      i_pad1;
	uint        i_file_acl;
	uint        i_dir_acl;
	uint        i_dtime;
	uint        i_version;
	uint        i_block_group;
	uint        i_next_alloc_block;
	uint        i_next_alloc_goal;
	uint        i_prealloc_block;
	uint        i_prealloc_count;
};