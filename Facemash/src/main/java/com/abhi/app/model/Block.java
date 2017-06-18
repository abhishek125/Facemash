package com.abhi.app.model;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "block")
public class Block implements Serializable {
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private BlockPK blockPk;
	public Block(){
		
	}
	public BlockPK getBlockPk() {
		return blockPk;
	}

	public void setBlockPk(BlockPK blockPk) {
		this.blockPk = blockPk;
	}

}
