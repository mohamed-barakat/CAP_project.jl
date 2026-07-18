# SPDX-License-Identifier: GPL-2.0-or-later
# Toposes: Elementary toposes
#
# Reading the implementation part of the package.
#

## Topos
include( "gap/ToposMethodRecord.gi.autogen.jl" );
include( "gap/ToposMethodRecordInstallations.autogen.gi.autogen.jl" );
include( "gap/Topos.gi.autogen.jl" );

include( "gap/ToposDerivedMethods.gi.autogen.jl" );
include( "gap/ToposDerivedMethods.semiautogen.gi.autogen.jl" );

## Category of relations
include( "gap/CategoryOfRelations.gi.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    include( "gap/ToolsUsingDigraphs.gi.autogen.jl" );
fi;
# =#

## DPO
include( "gap/DPO.gi.autogen.jl" );
