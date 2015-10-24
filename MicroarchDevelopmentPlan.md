Refer to [this page](http://docs.google.com/View?docid=df39snmn_10g5gbr3) for the original project proposal.

# Milestones & Deadlines #

Initially taken from Professor Harris's Milestone Definitions.  The date given is the deadline for the given milestone.

  1. Microarchitecture Team Organization - Sat. Jan 20
  1. CPU Block Diagram - Thur. Feb 1
  1. Memory System Specification - Sun. Jan 28
  1. Test Plan/Implementation - Sun. Jan 28
  1. Multiply/Division Instructions - Sun. Jan 28
  1. Exceptions - Sun. Jan 28
  1. CPU Function Complete - Sun. Jan 28
  1. RTL Function Complete - Thur. Feb 1
  1. RTL Tuning - Thur. Feb 8th
  1. CPU Validated - Sat. Feb 10th
  1. RTL Validated - Tue. Feb 13th
  1. Chip Report - Thur. Feb 15th

# Secondary, Desirable Tasks #

  * Organization: Rework modules so they are more easy to implement.
  * Optimization: Simplify and improve design wherever possible.
  * GCC: check that code compiled in gcc only gives instructions supported by processor.

# Milestone Subtasks/Assignments #

## Team Organization ##

Roles

  * Chief Microachitect: Carl Nygaard
  * Memory Microachitect: Nate Pinckney
  * Exception Microarchitect: Thomas Barr
  * Testing, validation: Matt Totino

## CPU Block Diagram ##

Assigned To: Carl Nygaard

To be completed in Visio.  Any modifications to the design made by other team members must be compiled together and provided to Carl for modification to the block diagram.

## Memory System Specification ##

Assigned to: Nate Pinckney

Subtasks:
  * Write detailed [MemorySystemSpecifications](MemorySystemSpecifications.md)
  * Create (identical) direct-mapped write-through instruction and data caches
  * Support cache bypassing (via upper bits of memory address)
  * Support cache swapping (using the swc bit available in the status register)
  * Support cache isolation (using the isc bit available in the status register)

## Test Plan/Implementation ##

Assigned to: multiple

Subtasks:
  * Develop test plan -- Assigned to Matt
  * Develop tests for various instructions (Corner case) -- Assigned to Matt
  * Develop tests for cache -- Assigned to Nate

## Multiply/Division Instructions ##

Assigned to: (Prof Harris)

Subtasks:
  * Create HI/LO registers with accessors
  * Create separate unit for multiplication and division
  * Stall the processor when a HI/LO read wants unavailable results


## Exceptions ##

Assigned to: Thomas

Subtasks:
  * Implement all remaining exceptions
  * Implemented break, syscall, and rfe instructions
  * Shrink/simplify interface to exceptionunit (e.g. remove some/all the 32 bit buses)
  * Separate out exception control from exception datapath

## CPU Function Complete ##

Assigned to: whole team

## RTL Function Complete ##

Assigned to: whole team

## RTL Tuning ##

Assigned to: whole team (broken down by subtask)

Subtasks:
  * High Level repartitioning - To be assigned
    * Where appropriate, add modules or change modules to facilitate circuit design
  * Datapath - To be assigned
    * Repartition to make datapath more modular
    * Separate 32 bit and 5 bit lines.
    * Datapath optimization
  * Control - To be assigned
    * Separate PLA control from random control and turn random control into PLA control where appropriate.