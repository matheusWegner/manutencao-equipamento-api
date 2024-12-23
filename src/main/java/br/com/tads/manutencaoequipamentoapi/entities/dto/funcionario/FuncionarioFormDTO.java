package br.com.tads.manutencaoequipamentoapi.entities.dto.funcionario;

import java.time.LocalDate;



import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.NotBlank;


public record FuncionarioFormDTO(Long id , 
                                @NotBlank(message = "o nome é obrigatório") String nome , 
                                @NotBlank(message = "o email é obrigatório") String email  ,
                                @NotBlank(message = "a senha é obrigatória") String senha , 
                                @JsonFormat(pattern = "dd/MM/yyyy") LocalDate dtNascimento) {
    
}
